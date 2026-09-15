class ProtocolItem {
  const ProtocolItem({
    required this.id,
    required this.userId,
    required this.name,
    required this.useManual,
    required this.useReachZones,
    required this.useActivity,
    required this.activityEngine,
    required this.createdAt,
    required this.updatedAt,
    this.sessionCount = 0,
  });

  final int id;
  final int userId;
  final String name;
  final bool useManual;
  final bool useReachZones;
  final bool useActivity;
  final String activityEngine;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int sessionCount;

  String get modeLabel {
    final parts = <String>[
      if (useManual) 'Manuel',
      if (useReachZones) 'Zones',
      if (useActivity) 'Activités',
    ];
    return parts.isEmpty ? 'Vide' : parts.join(' · ');
  }
}
