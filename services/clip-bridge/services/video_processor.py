from __future__ import annotations

import cv2

from schemas import ActivitySegment, FrameAnalysis, VideoAnalysis
from services.clip_service import ClipService


def analyze_video(
    service: ClipService,
    path: str,
    labels: list[str],
    sample_every_s: float = 0.4,
    min_segment_s: float = 0.5,
) -> VideoAnalysis:
    capture = cv2.VideoCapture(path)
    if not capture.isOpened():
        raise ValueError("Impossible d'ouvrir la vidéo.")
    fps = capture.get(cv2.CAP_PROP_FPS) or 25.0
    frame_interval = max(int(fps * sample_every_s), 1)
    raw: list[tuple[float, FrameAnalysis]] = []
    index = 0
    ok, frame = capture.read()
    while ok:
        if index % frame_interval == 0:
            ok_enc, buffer = cv2.imencode(".jpg", frame)
            if ok_enc:
                t = index / fps
                raw.append((t, service.analyze_image(buffer.tobytes(), labels)))
        index += 1
        ok, frame = capture.read()
    duration = index / fps
    capture.release()
    segments = _smooth(raw, duration, min_segment_s)
    return VideoAnalysis(
        segments=segments,
        frame_count=len(raw),
        duration=duration,
    )


def _smooth(
    raw: list[tuple[float, FrameAnalysis]],
    duration: float,
    min_segment_s: float,
) -> list[ActivitySegment]:
    if not raw:
        return []
    grouped: list[ActivitySegment] = []
    start, current = raw[0][0], raw[0][1]
    confs = [current.confidence]
    for t, analysis in raw[1:]:
        if analysis.label == current.label:
            confs.append(analysis.confidence)
            continue
        grouped.append(
            ActivitySegment(
                start_time=start,
                end_time=t,
                label=current.label,
                average_confidence=sum(confs) / len(confs),
            )
        )
        start, current, confs = t, analysis, [analysis.confidence]
    grouped.append(
        ActivitySegment(
            start_time=start,
            end_time=duration,
            label=current.label,
            average_confidence=sum(confs) / len(confs),
        )
    )
    return [s for s in grouped if (s.end_time - s.start_time) >= min_segment_s]
