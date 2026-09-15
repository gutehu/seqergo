from __future__ import annotations

import io

import torch
from PIL import Image
from transformers import CLIPModel, CLIPProcessor

from schemas import FrameAnalysis, LabelScore


class ClipService:
    def __init__(self) -> None:
        self.device = "cuda" if torch.cuda.is_available() else "cpu"
        self.model = CLIPModel.from_pretrained("openai/clip-vit-base-patch32")
        self.processor = CLIPProcessor.from_pretrained(
            "openai/clip-vit-base-patch32"
        )
        self.model.to(self.device)
        self.model.eval()

    def analyze_image(self, image_bytes: bytes, labels: list[str]) -> FrameAnalysis:
        if len(labels) < 1:
            raise ValueError("Au moins un libellé est requis.")
        image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
        inputs = self.processor(
            text=labels,
            images=image,
            return_tensors="pt",
            padding=True,
        )
        inputs = {k: v.to(self.device) for k, v in inputs.items()}
        with torch.no_grad():
            outputs = self.model(**inputs)
            probs = outputs.logits_per_image.softmax(dim=-1)[0]
        scores = [
            LabelScore(label=label, score=float(probs[i].item()))
            for i, label in enumerate(labels)
        ]
        winner = max(scores, key=lambda s: s.score)
        return FrameAnalysis(
            label=winner.label,
            confidence=winner.score,
            scores=scores,
        )
