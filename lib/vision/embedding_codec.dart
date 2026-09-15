import 'dart:typed_data';

Uint8List encodeEmbedding(List<double> values) {
  return Float32List.fromList(values).buffer.asUint8List();
}

List<double> decodeEmbedding(Uint8List bytes) {
  final aligned = bytes.offsetInBytes % 4 == 0
      ? bytes
      : Uint8List.fromList(bytes);
  return Float32List.view(
    aligned.buffer,
    aligned.offsetInBytes,
    aligned.lengthInBytes ~/ 4,
  ).toList();
}
