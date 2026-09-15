import '../domain/reach_zone_models.dart';

/// Suit l'entrée / sortie de chaque zone SEQOIA manuelle, avec 2° d'hystérésis.
class ReachZoneEngine {
  ReachZoneEngine(this.recipes, {this.hysteresisDeg = 2});

  final List<ReachZoneRecipeItem> recipes;
  final double hysteresisDeg;
  final Map<int, bool> _inZone = {};

  Map<int, bool> get current => Map.unmodifiable(_inZone);

  /// Retourne les recettes dont l'état a changé : id → dans la zone.
  Map<int, bool> update(Map<ReachJoint, double?> angles) {
    final changes = <int, bool>{};
    for (final recipe in recipes) {
      final angle = angles[recipe.joint];
      final wasIn = _inZone[recipe.id] ?? false;
      final nowIn = angle == null
          ? false
          : _inside(recipe, angle, wasIn);
      if (nowIn != wasIn) {
        _inZone[recipe.id] = nowIn;
        changes[recipe.id] = nowIn;
      } else if (!_inZone.containsKey(recipe.id)) {
        _inZone[recipe.id] = nowIn;
      }
    }
    return changes;
  }

  bool _inside(ReachZoneRecipeItem recipe, double angle, bool wasIn) {
    if (recipe.kind == ReachRecipeKind.validate) {
      final threshold = recipe.validateAngle;
      return wasIn
          ? angle >= threshold - hysteresisDeg
          : angle >= threshold;
    }
    final min = recipe.zoneMin ?? recipe.validateAngle - 5;
    final max = recipe.zoneMax ?? recipe.validateAngle + 5;
    if (wasIn) {
      return angle >= min - hysteresisDeg && angle <= max + hysteresisDeg;
    }
    return angle >= min && angle <= max;
  }
}
