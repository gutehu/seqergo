import 'package:flutter/material.dart';

import 'activity_engine.dart';
import 'metric_kind.dart';
import 'reach_zone_models.dart';

class ObservableClassItem {
  const ObservableClassItem({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.subclasses,
  });

  final int id;
  final String name;
  final int sortOrder;
  final List<ObservableSubclassItem> subclasses;
}

class ObservableSubclassItem {
  const ObservableSubclassItem({
    required this.id,
    required this.classId,
    required this.className,
    required this.name,
    required this.metricType,
    required this.colorValue,
    required this.sortOrder,
  });

  final int id;
  final int classId;
  final String className;
  final String name;
  final MetricKind metricType;
  final int colorValue;
  final int sortOrder;

  Color get color => Color(colorValue);
}

class SessionSummary {
  const SessionSummary({
    required this.id,
    required this.startedAt,
    this.endedAt,
    this.useManual = true,
    this.useReachZones = false,
    this.useActivity = false,
    this.activityEngine = ActivityEngineKind.observer,
    this.protocolId,
    this.protocolName,
    this.userId,
    this.name = '',
  });

  final int id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final bool useManual;
  final bool useReachZones;
  final bool useActivity;
  final ActivityEngineKind activityEngine;
  final int? protocolId;
  final String? protocolName;
  final int? userId;
  final String name;

  bool get isOpen => endedAt == null;

  String get displayName {
    final named = name.trim();
    if (named.isNotEmpty) return named;
    return protocolName ?? 'Observation';
  }

  String get modeLabel {
    final parts = <String>[
      if (useManual) 'Manuel',
      if (useReachZones) 'Zones',
      if (useActivity) 'Activités',
    ];
    return parts.isEmpty ? 'Session' : parts.join(' · ');
  }
}

class LearnedActivityItem {
  const LearnedActivityItem({
    required this.id,
    required this.name,
    required this.clipPath,
    required this.colorValue,
    required this.sortOrder,
    this.kind = 'visual',
    this.sampleCount = 0,
  });

  final int id;
  final String name;
  final String clipPath;
  final int colorValue;
  final int sortOrder;
  final String kind;
  final int sampleCount;

  Color get color => Color(colorValue);

  bool get isPrompt => kind == 'prompt';
}

class ActivityEventItem {
  const ActivityEventItem({
    required this.id,
    required this.activityId,
    required this.occurredAt,
  });

  final int id;
  final int activityId;
  final DateTime occurredAt;
}

class ActivityIntervalItem {
  const ActivityIntervalItem({
    required this.id,
    required this.activityId,
    required this.startedAt,
    this.endedAt,
  });

  final int id;
  final int activityId;
  final DateTime startedAt;
  final DateTime? endedAt;

  bool get isOpen => endedAt == null;

  Duration elapsed([DateTime? now]) {
    final end = endedAt ?? now ?? DateTime.now();
    return end.difference(startedAt);
  }
}

enum ActographLaneKind { count, duration, activity, zone }

class ActographLane {
  const ActographLane({
    required this.key,
    required this.name,
    required this.color,
    required this.kind,
    required this.sourceLabel,
    this.subclassId,
    this.activityId,
    this.recipeId,
  });

  final String key;
  final String name;
  final Color color;
  final ActographLaneKind kind;
  final String sourceLabel;
  final int? subclassId;
  final int? activityId;
  final int? recipeId;
}

class CountEventItem {
  const CountEventItem({
    required this.id,
    required this.subclassId,
    required this.occurredAt,
  });

  final int id;
  final int subclassId;
  final DateTime occurredAt;
}

class DurationIntervalItem {
  const DurationIntervalItem({
    required this.id,
    required this.subclassId,
    required this.startedAt,
    this.endedAt,
  });

  final int id;
  final int subclassId;
  final DateTime startedAt;
  final DateTime? endedAt;

  bool get isOpen => endedAt == null;

  Duration elapsed([DateTime? now]) {
    final end = endedAt ?? now ?? DateTime.now();
    return end.difference(startedAt);
  }
}

class SessionTimeline {
  const SessionTimeline({
    required this.session,
    required this.classes,
    required this.countEvents,
    required this.intervals,
    this.activities = const [],
    this.activityEvents = const [],
    this.activityIntervals = const [],
    this.reachRecipes = const [],
    this.reachIntervals = const [],
  });

  final SessionSummary session;
  final List<ObservableClassItem> classes;
  final List<CountEventItem> countEvents;
  final List<DurationIntervalItem> intervals;
  final List<LearnedActivityItem> activities;
  final List<ActivityEventItem> activityEvents;
  final List<ActivityIntervalItem> activityIntervals;
  final List<ReachZoneRecipeItem> reachRecipes;
  final List<ReachZoneIntervalItem> reachIntervals;

  List<ObservableSubclassItem> get allSubclasses => [
        for (final c in classes) ...c.subclasses,
      ];

  Duration subclassElapsed(int subclassId, [DateTime? now]) {
    return intervals
        .where((i) => i.subclassId == subclassId)
        .fold<Duration>(Duration.zero, (sum, i) => sum + i.elapsed(now));
  }

  int subclassCount(int subclassId) {
    return countEvents.where((e) => e.subclassId == subclassId).length;
  }

  Duration activityElapsed(int activityId, [DateTime? now]) {
    return activityIntervals
        .where((i) => i.activityId == activityId)
        .fold<Duration>(Duration.zero, (sum, i) => sum + i.elapsed(now));
  }

  Duration reachElapsed(int recipeId, [DateTime? now]) {
    return reachIntervals
        .where((i) => i.recipeId == recipeId)
        .fold<Duration>(Duration.zero, (sum, i) => sum + i.elapsed(now));
  }

  bool reachIsRunning(int recipeId) {
    return reachIntervals.any((i) => i.recipeId == recipeId && i.isOpen);
  }

  bool activityIsRunning(int activityId) {
    return activityIntervals.any((i) => i.activityId == activityId && i.isOpen);
  }

  List<ActographLane> get lanes {
    return [
      if (session.useManual)
        for (final sub in allSubclasses)
          ActographLane(
            key: 'manual-${sub.id}',
            name: sub.name,
            color: sub.color,
            kind: sub.metricType == MetricKind.duration
                ? ActographLaneKind.duration
                : ActographLaneKind.count,
            sourceLabel: 'Manuel',
            subclassId: sub.id,
          ),
      if (session.useReachZones)
        if (reachRecipes.isEmpty)
          const ActographLane(
            key: 'zones',
            name: "Zones d'atteinte",
            color: Color(0xFF4F46E5),
            kind: ActographLaneKind.zone,
            sourceLabel: 'Zones',
          )
        else
          for (final recipe in reachRecipes)
            ActographLane(
              key: 'zone-${recipe.id}',
              name: recipe.label,
              color: recipe.color,
              kind: ActographLaneKind.zone,
              sourceLabel: 'Zones',
              recipeId: recipe.id,
            ),
      if (session.useActivity)
        for (final activity in activities)
          ActographLane(
            key: 'activity-${activity.id}',
            name: activity.name,
            color: activity.color,
            kind: ActographLaneKind.activity,
            sourceLabel: 'Activité',
            activityId: activity.id,
          ),
    ];
  }
}
