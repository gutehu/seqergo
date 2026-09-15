import 'package:flutter/material.dart';

enum ReachSide { gauche, droit }

enum ReachJointFamily { genou, hanche, epaule, coude }

enum ReachJoint {
  genouGauche,
  genouDroit,
  hancheGauche,
  hancheDroit,
  epauleGauche,
  epauleDroit,
  coudeGauche,
  coudeDroit,
}

enum ReachRecipeKind { validate, chrono }

extension ReachSideLabel on ReachSide {
  String get label => this == ReachSide.gauche ? 'Gauche' : 'Droit';
  String get short => this == ReachSide.gauche ? 'G' : 'D';
}

extension ReachJointFamilyLabel on ReachJointFamily {
  String get label => switch (this) {
        ReachJointFamily.genou => 'Genou',
        ReachJointFamily.hanche => 'Hanche',
        ReachJointFamily.epaule => 'Épaule',
        ReachJointFamily.coude => 'Coude',
      };
}

extension ReachJointInfo on ReachJoint {
  ReachSide get side => switch (this) {
        ReachJoint.genouGauche ||
        ReachJoint.hancheGauche ||
        ReachJoint.epauleGauche ||
        ReachJoint.coudeGauche =>
          ReachSide.gauche,
        ReachJoint.genouDroit ||
        ReachJoint.hancheDroit ||
        ReachJoint.epauleDroit ||
        ReachJoint.coudeDroit =>
          ReachSide.droit,
      };

  ReachJointFamily get family => switch (this) {
        ReachJoint.genouGauche || ReachJoint.genouDroit =>
          ReachJointFamily.genou,
        ReachJoint.hancheGauche || ReachJoint.hancheDroit =>
          ReachJointFamily.hanche,
        ReachJoint.epauleGauche || ReachJoint.epauleDroit =>
          ReachJointFamily.epaule,
        ReachJoint.coudeGauche || ReachJoint.coudeDroit =>
          ReachJointFamily.coude,
      };

  String get label => '${family.label} ${side.label.toLowerCase()}';

  static ReachJoint of(ReachJointFamily family, ReachSide side) {
    return switch ((family, side)) {
      (ReachJointFamily.genou, ReachSide.gauche) => ReachJoint.genouGauche,
      (ReachJointFamily.genou, ReachSide.droit) => ReachJoint.genouDroit,
      (ReachJointFamily.hanche, ReachSide.gauche) => ReachJoint.hancheGauche,
      (ReachJointFamily.hanche, ReachSide.droit) => ReachJoint.hancheDroit,
      (ReachJointFamily.epaule, ReachSide.gauche) => ReachJoint.epauleGauche,
      (ReachJointFamily.epaule, ReachSide.droit) => ReachJoint.epauleDroit,
      (ReachJointFamily.coude, ReachSide.gauche) => ReachJoint.coudeGauche,
      (ReachJointFamily.coude, ReachSide.droit) => ReachJoint.coudeDroit,
    };
  }

  static ReachJoint fromStorage(String value) {
    return switch (value) {
      'genou' || 'genouDroit' => ReachJoint.genouDroit,
      'genouGauche' => ReachJoint.genouGauche,
      'hanche' || 'hancheDroit' => ReachJoint.hancheDroit,
      'hancheGauche' => ReachJoint.hancheGauche,
      'epaule' || 'epauleDroit' => ReachJoint.epauleDroit,
      'epauleGauche' => ReachJoint.epauleGauche,
      'coude' || 'coudeDroit' => ReachJoint.coudeDroit,
      'coudeGauche' => ReachJoint.coudeGauche,
      _ => ReachJoint.epauleDroit,
    };
  }
}

extension ReachRecipeKindCodec on ReachRecipeKind {
  String get storageValue => name;

  static ReachRecipeKind fromStorage(String value) {
    return value == 'chrono' ? ReachRecipeKind.chrono : ReachRecipeKind.validate;
  }
}

class ReachZoneRecipeItem {
  const ReachZoneRecipeItem({
    required this.id,
    required this.protocolId,
    required this.joint,
    required this.kind,
    required this.validateAngle,
    this.zoneMin,
    this.zoneMax,
    required this.colorValue,
    required this.sortOrder,
  });

  final int id;
  final int protocolId;
  final ReachJoint joint;
  final ReachRecipeKind kind;
  final double validateAngle;
  final double? zoneMin;
  final double? zoneMax;
  final int colorValue;
  final int sortOrder;

  Color get color => Color(colorValue);

  String get label {
    if (kind == ReachRecipeKind.validate) {
      return '${joint.label} ≥ ${validateAngle.round()}°';
    }
    final min = zoneMin?.round() ?? 0;
    final max = zoneMax?.round() ?? 0;
    return '${joint.label} $min–$max°';
  }

  bool contains(double angle) {
    if (kind == ReachRecipeKind.validate) {
      return angle >= validateAngle;
    }
    final min = zoneMin ?? validateAngle - 5;
    final max = zoneMax ?? validateAngle + 5;
    return angle >= min && angle <= max;
  }
}

class ReachZoneIntervalItem {
  const ReachZoneIntervalItem({
    required this.id,
    required this.recipeId,
    required this.startedAt,
    this.endedAt,
  });

  final int id;
  final int recipeId;
  final DateTime startedAt;
  final DateTime? endedAt;

  bool get isOpen => endedAt == null;

  Duration elapsed([DateTime? now]) {
    final end = endedAt ?? now ?? DateTime.now();
    return end.difference(startedAt);
  }
}
