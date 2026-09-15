enum MetricKind {
  count,
  duration,
}

extension MetricKindCodec on MetricKind {
  String get storageValue {
    return switch (this) {
      MetricKind.count => 'count',
      MetricKind.duration => 'duration',
    };
  }

  static MetricKind fromStorage(String value) {
    return value == 'duration' ? MetricKind.duration : MetricKind.count;
  }

  String get label {
    return switch (this) {
      MetricKind.count => "Nombre d'actions",
      MetricKind.duration => 'Temps passé',
    };
  }
}

const subclassPalette = <int>[
  0xFF0F766E,
  0xFF4F46E5,
  0xFFC2410C,
  0xFF0369A1,
  0xFF7C3AED,
  0xFFBE185D,
  0xFF15803D,
  0xFFB45309,
  0xFF0E7490,
  0xFFA21CAF,
];
