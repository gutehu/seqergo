from pydantic import BaseModel, Field


class LabelScore(BaseModel):
    label: str
    score: float


class FrameAnalysis(BaseModel):
    label: str
    confidence: float
    scores: list[LabelScore]


class ActivitySegment(BaseModel):
    start_time: float = Field(description="Secondes depuis le début de la vidéo")
    end_time: float
    label: str
    average_confidence: float


class VideoAnalysis(BaseModel):
    segments: list[ActivitySegment]
    frame_count: int
    duration: float
