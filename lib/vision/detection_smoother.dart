class SmoothDetection {
  const SmoothDetection({this.id, this.label, this.confidence = 0});

  final int? id;
  final String? label;
  final double confidence;
}

/// Fenêtre glissante + durée minimale pour éviter le clignotement.
class DetectionSmoother {
  DetectionSmoother({
    this.windowSize = 3,
    this.minHold = const Duration(milliseconds: 180),
    this.minConfidence = 0.35,
  });

  final int windowSize;
  final Duration minHold;
  final double minConfidence;

  final List<({int? id, String? label, double confidence})> _window = [];
  SmoothDetection _emitted = const SmoothDetection();
  DateTime? _candidateSince;
  int? _candidateId;

  SmoothDetection get current => _emitted;

  SmoothDetection update({
    required DateTime now,
    int? id,
    String? label,
    required double confidence,
  }) {
    final accepted = confidence >= minConfidence ? id : null;
    final acceptedLabel = accepted == null ? null : label;
    _window.add((id: accepted, label: acceptedLabel, confidence: confidence));
    if (_window.length > windowSize) {
      _window.removeAt(0);
    }

    final majority = _majority();
    if (majority.id != _candidateId) {
      _candidateId = majority.id;
      _candidateSince = now;
    }
    final held = _candidateSince != null &&
        now.difference(_candidateSince!) >= minHold;
    if (held && majority.id != _emitted.id) {
      _emitted = SmoothDetection(
        id: majority.id,
        label: majority.label,
        confidence: majority.confidence,
      );
    } else if (_emitted.id != null) {
      _emitted = SmoothDetection(
        id: _emitted.id,
        label: _emitted.label,
        confidence: majority.id == _emitted.id ? majority.confidence : _emitted.confidence,
      );
    }
    return _emitted;
  }

  ({int? id, String? label, double confidence}) _majority() {
    if (_window.isEmpty) {
      return (id: null, label: null, confidence: 0);
    }
    final scores = <int?, double>{};
    final labels = <int?, String?>{};
    for (final item in _window) {
      scores[item.id] = (scores[item.id] ?? 0) + 1;
      labels[item.id] = item.label;
    }
    var bestId = _window.last.id;
    var best = -1.0;
    for (final e in scores.entries) {
      if (e.value > best) {
        best = e.value;
        bestId = e.key;
      }
    }
    final conf = _window
        .where((e) => e.id == bestId)
        .map((e) => e.confidence)
        .fold<double>(0, (a, b) => a + b);
    final n = _window.where((e) => e.id == bestId).length;
    return (
      id: bestId,
      label: labels[bestId],
      confidence: n == 0 ? 0 : conf / n,
    );
  }
}
