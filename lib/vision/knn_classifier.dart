import 'dart:math' as math;

class KnnPrediction {
  const KnnPrediction({
    required this.id,
    required this.label,
    required this.confidence,
  });

  final int id;
  final String label;
  final double confidence;
}

/// Classifieur KNN sur embeddings L2-normalisés (similarité cosinus).
class KnnClassifier {
  final Map<int, List<List<double>>> _samples = {};
  final Map<int, String> _labels = {};

  int get classCount => _samples.length;

  int sampleCount(int id) => _samples[id]?.length ?? 0;

  Map<int, String> get labels => Map.unmodifiable(_labels);

  void clear() {
    _samples.clear();
    _labels.clear();
  }

  void add({
    required int id,
    required String label,
    required List<double> embedding,
  }) {
    final unit = _normalize(embedding);
    if (unit == null) return;
    _labels[id] = label;
    _samples.putIfAbsent(id, () => []).add(unit);
  }

  KnnPrediction? predict(
    List<double> embedding, {
    int k = 3,
    double minSimilarity = 0.62,
  }) {
    final unit = _normalize(embedding);
    if (unit == null || _samples.isEmpty) return null;

    final neighbors = <({int id, double sim})>[];
    for (final entry in _samples.entries) {
      for (final sample in entry.value) {
        neighbors.add((id: entry.key, sim: _dot(unit, sample)));
      }
    }
    if (neighbors.isEmpty) return null;
    neighbors.sort((a, b) => b.sim.compareTo(a.sim));

    final bestSim = neighbors.first.sim;
    if (bestSim < minSimilarity) return null;

    final take = math.min(k, neighbors.length);
    final top = neighbors.take(take).toList();
    final votes = <int, double>{};
    for (final n in top) {
      votes[n.id] = (votes[n.id] ?? 0) + math.max(n.sim, 0);
    }
    var winner = top.first.id;
    var best = -1.0;
    var total = 0.0;
    for (final e in votes.entries) {
      total += e.value;
      if (e.value > best) {
        best = e.value;
        winner = e.key;
      }
    }
    final voteShare = total <= 0 ? 0.0 : (best / total).clamp(0.0, 1.0);
    final similarity = bestSim.clamp(0.0, 1.0);
    return KnnPrediction(
      id: winner,
      label: _labels[winner] ?? '?',
      confidence: math.min(voteShare, similarity),
    );
  }

  static List<double>? _normalize(List<double> v) {
    var sum = 0.0;
    for (final x in v) {
      sum += x * x;
    }
    if (sum <= 1e-12) return null;
    final inv = 1.0 / math.sqrt(sum);
    return [for (final x in v) x * inv];
  }

  static double _dot(List<double> a, List<double> b) {
    final n = math.min(a.length, b.length);
    var s = 0.0;
    for (var i = 0; i < n; i++) {
      s += a[i] * b[i];
    }
    return s;
  }
}
