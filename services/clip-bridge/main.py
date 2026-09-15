from __future__ import annotations

import json
from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import FastAPI, File, Form, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware

from schemas import FrameAnalysis, VideoAnalysis
from services.clip_service import ClipService
from services.video_processor import analyze_video

clip_service: ClipService | None = None


@asynccontextmanager
async def lifespan(_app: FastAPI):
    global clip_service
    clip_service = ClipService()
    yield
    clip_service = None


app = FastAPI(title="SeqErgo CLIP", lifespan=lifespan)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok", "device": clip_service.device if clip_service else "none"}


def _labels(raw: str) -> list[str]:
    try:
        parsed = json.loads(raw)
        if isinstance(parsed, list):
            return [str(item) for item in parsed if str(item).strip()]
    except json.JSONDecodeError:
        pass
    return [part.strip() for part in raw.split(",") if part.strip()]


@app.post("/analyze-frame", response_model=FrameAnalysis)
async def analyze_frame(
    image: UploadFile = File(...),
    labels: str = Form(...),
) -> FrameAnalysis:
    if clip_service is None:
        raise HTTPException(503, "Modèle CLIP non chargé")
    names = _labels(labels)
    if len(names) < 1:
        raise HTTPException(400, "labels manquants")
    data = await image.read()
    try:
        return clip_service.analyze_image(data, names)
    except Exception as error:  # noqa: BLE001
        raise HTTPException(400, str(error)) from error


@app.post("/analyze-video", response_model=VideoAnalysis)
async def analyze_video_endpoint(
    video: UploadFile = File(...),
    labels: str = Form(...),
    sample_every_s: float = Form(0.4),
) -> VideoAnalysis:
    if clip_service is None:
        raise HTTPException(503, "Modèle CLIP non chargé")
    names = _labels(labels)
    suffix = Path(video.filename or "clip.mp4").suffix or ".mp4"
    tmp = Path("/tmp") / f"seqergo_{video.filename or 'clip'}{suffix}"
    tmp.write_bytes(await video.read())
    try:
        return analyze_video(clip_service, str(tmp), names, sample_every_s)
    except Exception as error:  # noqa: BLE001
        raise HTTPException(400, str(error)) from error
    finally:
        tmp.unlink(missing_ok=True)
