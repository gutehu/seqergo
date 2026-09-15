String formatElapsed(Duration d) {
  final total = d.inMilliseconds;
  if (total < 0) return '00:00.0';
  final minutes = d.inMinutes;
  final seconds = d.inSeconds.remainder(60);
  final tenths = (d.inMilliseconds.remainder(1000) ~/ 100);
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.$tenths';
}

String formatClock(DateTime t) {
  final h = t.hour.toString().padLeft(2, '0');
  final m = t.minute.toString().padLeft(2, '0');
  final s = t.second.toString().padLeft(2, '0');
  return '$h:$m:$s';
}

String formatSessionStamp(DateTime t) {
  final d = t.day.toString().padLeft(2, '0');
  final mo = t.month.toString().padLeft(2, '0');
  return '$d/$mo/${t.year} ${formatClock(t)}';
}
