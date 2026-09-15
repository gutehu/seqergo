import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

const _modelUrl =
    'https://storage.googleapis.com/download.tensorflow.org/models/tflite/gpu/mobilenet_v1_1.0_224.tflite';

/// Extracteur d'embeddings MobileNet (sortie ImageNet 1001-d, utilisée comme vecteur).
class MobileNetEmbedder {
  Interpreter? _interpreter;
  var _inputSize = 224;
  var _outputSize = 1001;

  bool get isReady => _interpreter != null;

  int get inputSize => _inputSize;

  Future<void> load({void Function(String status)? onStatus}) async {
    if (_interpreter != null) return;
    onStatus?.call('Préparation du modèle MobileNet…');
    final file = await _ensureModel(onStatus);
    final options = InterpreterOptions()..threads = 1;
    final interpreter = Interpreter.fromFile(file, options: options);
    interpreter.allocateTensors();
    final inputShape = interpreter.getInputTensor(0).shape;
    final outputShape = interpreter.getOutputTensor(0).shape;
    if (inputShape.length >= 2) {
      _inputSize = inputShape[1];
    }
    _outputSize = outputShape.last;
    _interpreter = interpreter;
    onStatus?.call('MobileNet prêt.');
  }

  Future<File> _ensureModel(void Function(String status)? onStatus) async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'models'));
    await dir.create(recursive: true);
    final file = File(p.join(dir.path, 'mobilenet_v1_1.0_224.tflite'));
    if (await file.exists() && await file.length() > 1000000) {
      return file;
    }
    onStatus?.call('Téléchargement de MobileNet (une seule fois)…');
    final response = await http.get(Uri.parse(_modelUrl));
    if (response.statusCode != 200 || response.bodyBytes.length < 1000000) {
      throw StateError(
        'Impossible de télécharger MobileNet (${response.statusCode}).',
      );
    }
    await file.writeAsBytes(response.bodyBytes, flush: true);
    return file;
  }

  List<double> infer(List<double> rgb01) {
    final interpreter = _interpreter;
    if (interpreter == null) {
      throw StateError('MobileNet non chargé');
    }
    final expected = _inputSize * _inputSize * 3;
    if (rgb01.length != expected) {
      throw StateError('Taille d’entrée MobileNet invalide (${rgb01.length}).');
    }
    final input = rgb01.reshape([1, _inputSize, _inputSize, 3]);
    final output = List.filled(1 * _outputSize, 0.0).reshape([1, _outputSize]);
    interpreter.run(input, output);
    return [for (final v in output[0] as List) (v as num).toDouble()];
  }

  void dispose() {
    try {
      _interpreter?.close();
    } catch (_) {}
    _interpreter = null;
  }
}
