enum ActivityEngineKind {
  observer,
  knn,
  clip,
}

extension ActivityEngineKindCodec on ActivityEngineKind {
  String get storageValue => name;

  static ActivityEngineKind fromStorage(String value) {
    return ActivityEngineKind.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ActivityEngineKind.observer,
    );
  }

  String get title {
    return switch (this) {
      ActivityEngineKind.observer => 'Relevé manuel',
      ActivityEngineKind.knn => 'Apprentissage visuel',
      ActivityEngineKind.clip => 'Prompts texte',
    };
  }

  String get subtitle {
    return switch (this) {
      ActivityEngineKind.observer =>
        'Vous tapez pour démarrer et arrêter le chrono.',
      ActivityEngineKind.knn =>
        'Exemples caméra + MobileNet / KNN, 100 % sur le téléphone.',
      ActivityEngineKind.clip =>
        'Descriptions texte comparées aux frames via CLIP (PC).',
    };
  }
}
