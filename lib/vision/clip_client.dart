import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ClipLabelScore {
  const ClipLabelScore({required this.label, required this.score});

  final String label;
  final double score;
}

class ClipFrameResult {
  const ClipFrameResult({
    required this.label,
    required this.confidence,
    required this.scores,
  });

  final String label;
  final double confidence;
  final List<ClipLabelScore> scores;
}

class ClipClient {
  ClipClient({required this.baseUrl, http.Client? httpClient})
      : _http = httpClient ?? http.Client();

  /// Concurrent CLIP pour n'enregistrer que si un vrai modèle gagne.
  static const unknownLabel = 'aucune activité connue';

  final String baseUrl;
  final http.Client _http;

  static List<String> labelsWithUnknown(Iterable<String> labels) {
    return [...labels, unknownLabel];
  }

  static String? recognizedLabel(
    ClipFrameResult result,
    Iterable<String> trained,
  ) {
    final names = trained.toSet();
    if (!names.contains(result.label)) return null;
    return result.label;
  }

  Uri _uri(String route) {
    final root = baseUrl.trim().replaceAll(RegExp(r'/$'), '');
    return Uri.parse('$root$route');
  }

  Future<bool> ping() async {
    try {
      final response = await _http
          .get(_uri('/health'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<ClipFrameResult> analyzeFrame({
    required Uint8List jpeg,
    required List<String> labels,
  }) async {
    final request = http.MultipartRequest('POST', _uri('/analyze-frame'))
      ..fields['labels'] = jsonEncode(labels)
      ..files.add(
        http.MultipartFile.fromBytes('image', jpeg, filename: 'frame.jpg'),
      );
    final streamed = await _http.send(request).timeout(
          const Duration(seconds: 20),
        );
    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode != 200) {
      throw StateError('CLIP ${streamed.statusCode}: $body');
    }
    final json = jsonDecode(body) as Map<String, dynamic>;
    final scores = <ClipLabelScore>[
      for (final item in (json['scores'] as List<dynamic>? ?? const []))
        ClipLabelScore(
          label: (item as Map<String, dynamic>)['label'] as String,
          score: (item['score'] as num).toDouble(),
        ),
    ];
    return ClipFrameResult(
      label: json['label'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      scores: scores,
    );
  }
}
