import 'package:flutter/material.dart';

enum ObservationMode {
  manual,
  reachZones,
  activityRecognition,
}

class ProtocolSelection {
  const ProtocolSelection({
    this.manual = false,
    this.reachZones = false,
    this.activity = false,
  });

  final bool manual;
  final bool reachZones;
  final bool activity;

  bool get isEmpty => !manual && !reachZones && !activity;

  ProtocolSelection toggle(ObservationMode mode) {
    return switch (mode) {
      ObservationMode.manual => ProtocolSelection(
          manual: !manual,
          reachZones: reachZones,
          activity: activity,
        ),
      ObservationMode.reachZones => ProtocolSelection(
          manual: manual,
          reachZones: !reachZones,
          activity: activity,
        ),
      ObservationMode.activityRecognition => ProtocolSelection(
          manual: manual,
          reachZones: reachZones,
          activity: !activity,
        ),
    };
  }

  bool isSelected(ObservationMode mode) {
    return switch (mode) {
      ObservationMode.manual => manual,
      ObservationMode.reachZones => reachZones,
      ObservationMode.activityRecognition => activity,
    };
  }
}

extension ObservationModeUi on ObservationMode {
  String get title {
    return switch (this) {
      ObservationMode.manual => 'Mode manuel',
      ObservationMode.reachZones => "Zones d'atteinte",
      ObservationMode.activityRecognition => "Reconnaissance d'activité",
    };
  }

  String get subtitle {
    return switch (this) {
      ObservationMode.manual =>
        "L'observateur saisit et valide lui-même les actions de l'opérateur.",
      ObservationMode.reachZones =>
        'Mesure automatique gauche / droite (genou, hanche, épaule, coude).',
      ObservationMode.activityRecognition =>
        "Enregistrez au moins un modèle. Seules les reconnaissances certaines sont chronométrées.",
    };
  }

  IconData get icon {
    return switch (this) {
      ObservationMode.manual => Icons.touch_app_outlined,
      ObservationMode.reachZones => Icons.crop_free,
      ObservationMode.activityRecognition => Icons.accessibility_new,
    };
  }

  Color get accent {
    return switch (this) {
      ObservationMode.manual => const Color(0xFF0F766E),
      ObservationMode.reachZones => const Color(0xFF4F46E5),
      ObservationMode.activityRecognition => const Color(0xFFC2410C),
    };
  }
}
