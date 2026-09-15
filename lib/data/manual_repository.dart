import 'dart:async';

import 'package:drift/drift.dart';

import '../domain/activity_engine.dart';
import '../domain/manual_models.dart';
import '../domain/metric_kind.dart';
import '../domain/protocol_models.dart';
import '../domain/reach_zone_models.dart';
import '../vision/embedding_codec.dart';
import '../vision/knn_classifier.dart';
import 'database.dart';

class ManualRepository {
  ManualRepository(this._db, {this.userId, this.protocolId});

  final AppDatabase _db;
  final int? userId;
  final int? protocolId;

  Stream<List<ObservableClassItem>> watchTaxonomy({int? protocolId}) {
    final pid = protocolId ?? this.protocolId;
    final query = _db.select(_db.observableClasses)
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    if (pid != null) {
      query.where((t) => t.protocolId.equals(pid));
    }
    final subclasses$ = (_db.select(_db.observableSubclasses)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();

    return _combine2(query.watch(), subclasses$, _mapTaxonomy);
  }

  Future<List<ObservableClassItem>> loadTaxonomy() => watchTaxonomy().first;

  Future<int> addClass(String name) async {
    final pid = protocolId;
    if (pid == null) {
      throw StateError('protocolId requis pour créer une classe');
    }
    final count = await (_db.select(
      _db.observableClasses,
    )..where((t) => t.protocolId.equals(pid))).get();
    return _db
        .into(_db.observableClasses)
        .insert(
          ObservableClassesCompanion.insert(
            protocolId: Value(pid),
            name: name.trim(),
            sortOrder: count.length,
            createdAt: DateTime.now(),
          ),
        );
  }

  Future<void> renameClass(int id, String name) {
    return (_db.update(_db.observableClasses)..where((t) => t.id.equals(id)))
        .write(ObservableClassesCompanion(name: Value(name.trim())));
  }

  Future<void> deleteClass(int id) {
    return (_db.delete(_db.observableClasses)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> addSubclass({
    required int classId,
    required String name,
    required MetricKind metricType,
  }) async {
    final existing = await (_db.select(
      _db.observableSubclasses,
    )..where((t) => t.classId.equals(classId))).get();
    final color = subclassPalette[existing.length % subclassPalette.length];
    return _db
        .into(_db.observableSubclasses)
        .insert(
          ObservableSubclassesCompanion.insert(
            classId: classId,
            name: name.trim(),
            metricType: metricType.storageValue,
            colorValue: color,
            sortOrder: existing.length,
          ),
        );
  }

  Future<void> deleteSubclass(int id) {
    return (_db.delete(_db.observableSubclasses)..where((t) => t.id.equals(id)))
        .go();
  }

  Future<int> startSession({
    bool useManual = true,
    bool useReachZones = false,
    bool useActivity = false,
    ActivityEngineKind activityEngine = ActivityEngineKind.observer,
    int? protocolId,
    int? userId,
  }) {
    return _db
        .into(_db.observationSessions)
        .insert(
          ObservationSessionsCompanion.insert(
            startedAt: DateTime.now(),
            useManual: Value(useManual),
            useReachZones: Value(useReachZones),
            useActivity: Value(useActivity),
            activityEngine: Value(activityEngine.storageValue),
            protocolId: Value(protocolId ?? this.protocolId),
            userId: Value(userId ?? this.userId),
          ),
        );
  }

  Future<int> startSessionFromProtocol(ProtocolItem protocol) {
    return startSession(
      useManual: protocol.useManual,
      useReachZones: protocol.useReachZones,
      useActivity: protocol.useActivity,
      activityEngine: ActivityEngineKindCodec.fromStorage(protocol.activityEngine),
      protocolId: protocol.id,
      userId: protocol.userId,
    );
  }

  Future<void> endSession(int sessionId) async {
    final now = DateTime.now();
    await (_db.update(_db.durationIntervals)
          ..where((t) => t.sessionId.equals(sessionId) & t.endedAt.isNull()))
        .write(DurationIntervalsCompanion(endedAt: Value(now)));
    await (_db.update(_db.activityIntervals)
          ..where((t) => t.sessionId.equals(sessionId) & t.endedAt.isNull()))
        .write(ActivityIntervalsCompanion(endedAt: Value(now)));
    await (_db.update(_db.reachZoneIntervals)
          ..where((t) => t.sessionId.equals(sessionId) & t.endedAt.isNull()))
        .write(ReachZoneIntervalsCompanion(endedAt: Value(now)));
    await (_db.update(
      _db.observationSessions,
    )..where((t) => t.id.equals(sessionId))).write(
      ObservationSessionsCompanion(endedAt: Value(now)),
    );
  }

  Future<void> renameSession(int sessionId, String name) {
    return (_db.update(_db.observationSessions)
          ..where((t) => t.id.equals(sessionId)))
        .write(ObservationSessionsCompanion(name: Value(name.trim())));
  }

  Future<int> createProtocol({
    required int userId,
    required String name,
    required bool useManual,
    required bool useReachZones,
    required bool useActivity,
    ActivityEngineKind activityEngine = ActivityEngineKind.observer,
  }) {
    final now = DateTime.now();
    return _db
        .into(_db.observationProtocols)
        .insert(
          ObservationProtocolsCompanion.insert(
            userId: userId,
            name: name.trim().isEmpty ? 'Sans nom' : name.trim(),
            useManual: Value(useManual),
            useReachZones: Value(useReachZones),
            useActivity: Value(useActivity),
            activityEngine: Value(activityEngine.storageValue),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  Future<void> updateProtocol({
    required int id,
    String? name,
    bool? useManual,
    bool? useReachZones,
    bool? useActivity,
    ActivityEngineKind? activityEngine,
  }) {
    return (_db.update(
      _db.observationProtocols,
    )..where((t) => t.id.equals(id))).write(
      ObservationProtocolsCompanion(
        name: name == null ? const Value.absent() : Value(name.trim()),
        useManual: useManual == null ? const Value.absent() : Value(useManual),
        useReachZones:
            useReachZones == null ? const Value.absent() : Value(useReachZones),
        useActivity: useActivity == null ? const Value.absent() : Value(useActivity),
        activityEngine: activityEngine == null
            ? const Value.absent()
            : Value(activityEngine.storageValue),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<ProtocolItem?> getProtocol(int id) async {
    final row = await (_db.select(
      _db.observationProtocols,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _mapProtocol(row, sessionCount: 0);
  }

  Future<void> deleteProtocol(int id) {
    return (_db.delete(
      _db.observationProtocols,
    )..where((t) => t.id.equals(id))).go();
  }

  Stream<List<ProtocolItem>> watchProtocols(int userId) {
    return _combine2(
      (_db.select(_db.observationProtocols)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
          .watch(),
      (_db.select(_db.observationSessions)
            ..where((t) => t.userId.equals(userId)))
          .watch(),
      (protocols, sessions) {
        final counts = <int, int>{};
        for (final s in sessions) {
          final pid = s.protocolId;
          if (pid == null) continue;
          counts[pid] = (counts[pid] ?? 0) + 1;
        }
        return [
          for (final row in protocols)
            _mapProtocol(row, sessionCount: counts[row.id] ?? 0),
        ];
      },
    );
  }

  ProtocolItem _mapProtocol(
    ObservationProtocol row, {
    required int sessionCount,
  }) {
    return ProtocolItem(
      id: row.id,
      userId: row.userId,
      name: row.name,
      useManual: row.useManual,
      useReachZones: row.useReachZones,
      useActivity: row.useActivity,
      activityEngine: row.activityEngine,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      sessionCount: sessionCount,
    );
  }

  Stream<List<SessionSummary>> watchSessions({int? userId}) {
    final uid = userId ?? this.userId;
    final sessions$ = _db.select(_db.observationSessions).join([
      leftOuterJoin(
        _db.observationProtocols,
        _db.observationProtocols.id.equalsExp(_db.observationSessions.protocolId),
      ),
    ]);
    if (uid != null) {
      sessions$.where(_db.observationSessions.userId.equals(uid));
    }
    sessions$.orderBy([
      OrderingTerm.desc(_db.observationSessions.startedAt),
    ]);
    return sessions$.watch().map((rows) {
      return [
        for (final row in rows)
          SessionSummary(
            id: row.readTable(_db.observationSessions).id,
            startedAt: row.readTable(_db.observationSessions).startedAt,
            endedAt: row.readTable(_db.observationSessions).endedAt,
            useManual: row.readTable(_db.observationSessions).useManual,
            useReachZones: row.readTable(_db.observationSessions).useReachZones,
            useActivity: row.readTable(_db.observationSessions).useActivity,
            activityEngine: ActivityEngineKindCodec.fromStorage(
              row.readTable(_db.observationSessions).activityEngine,
            ),
            protocolId: row.readTable(_db.observationSessions).protocolId,
            protocolName: row.readTableOrNull(_db.observationProtocols)?.name,
            userId: row.readTable(_db.observationSessions).userId,
            name: row.readTable(_db.observationSessions).name,
          ),
      ];
    });
  }

  Future<void> recordCount({
    required int sessionId,
    required int subclassId,
  }) {
    return _db
        .into(_db.countEvents)
        .insert(
          CountEventsCompanion.insert(
            sessionId: sessionId,
            subclassId: subclassId,
            occurredAt: DateTime.now(),
          ),
        );
  }

  Future<void> toggleDuration({
    required int sessionId,
    required int subclassId,
  }) async {
    final open = await (_db.select(_db.durationIntervals)
          ..where(
            (t) =>
                t.sessionId.equals(sessionId) &
                t.subclassId.equals(subclassId) &
                t.endedAt.isNull(),
          ))
        .getSingleOrNull();

    if (open != null) {
      await (_db.update(
        _db.durationIntervals,
      )..where((t) => t.id.equals(open.id))).write(
        DurationIntervalsCompanion(endedAt: Value(DateTime.now())),
      );
      return;
    }

    await _db
        .into(_db.durationIntervals)
        .insert(
          DurationIntervalsCompanion.insert(
            sessionId: sessionId,
            subclassId: subclassId,
            startedAt: DateTime.now(),
          ),
        );
  }

  Stream<List<LearnedActivityItem>> watchActivities({int? protocolId}) {
    final pid = protocolId ?? this.protocolId;
    final query = _db.select(_db.learnedActivities)
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    if (pid != null) {
      query.where((t) => t.protocolId.equals(pid));
    }
    return _combine2(
      query.watch(),
      _db.select(_db.activityEmbeddings).watch(),
      (rows, embeddings) {
        final counts = <int, int>{};
        for (final e in embeddings) {
          counts[e.activityId] = (counts[e.activityId] ?? 0) + 1;
        }
        return [
          for (final row in rows)
            LearnedActivityItem(
              id: row.id,
              name: row.name,
              clipPath: row.clipPath,
              colorValue: row.colorValue,
              sortOrder: row.sortOrder,
              kind: row.kind,
              sampleCount: counts[row.id] ?? 0,
            ),
        ];
      },
    );
  }

  Future<int> addActivity({
    required String name,
    String clipPath = '',
    String kind = 'visual',
  }) async {
    final pid = protocolId;
    if (pid == null) {
      throw StateError('protocolId requis pour créer une activité');
    }
    final existing = await (_db.select(
      _db.learnedActivities,
    )..where((t) => t.protocolId.equals(pid))).get();
    final color = subclassPalette[existing.length % subclassPalette.length];
    return _db
        .into(_db.learnedActivities)
        .insert(
          LearnedActivitiesCompanion.insert(
            protocolId: Value(pid),
            name: name.trim(),
            clipPath: clipPath,
            colorValue: color,
            sortOrder: existing.length,
            createdAt: DateTime.now(),
            kind: Value(kind),
          ),
        );
  }

  Future<void> renameActivity(int id, String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw StateError("Le nom de l'activité est vide.");
    }
    return (_db.update(_db.learnedActivities)..where((t) => t.id.equals(id)))
        .write(LearnedActivitiesCompanion(name: Value(trimmed)));
  }

  Future<void> addEmbedding({
    required int activityId,
    required List<double> vector,
  }) {
    return _db
        .into(_db.activityEmbeddings)
        .insert(
          ActivityEmbeddingsCompanion.insert(
            activityId: activityId,
            vector: encodeEmbedding(vector),
          ),
        );
  }

  Future<KnnClassifier> loadKnnClassifier({int? protocolId}) async {
    final pid = protocolId ?? this.protocolId;
    final knn = KnnClassifier();
    final query = _db.select(_db.learnedActivities);
    if (pid != null) {
      query.where((t) => t.protocolId.equals(pid));
    }
    final activities = await query.get();
    final embeddings = await _db.select(_db.activityEmbeddings).get();
    final byId = {for (final a in activities) a.id: a};
    for (final row in embeddings) {
      final activity = byId[row.activityId];
      if (activity == null) continue;
      knn.add(
        id: activity.id,
        label: activity.name,
        embedding: decodeEmbedding(row.vector),
      );
    }
    return knn;
  }

  Future<void> applyDetectedActivity({
    required int sessionId,
    int? activityId,
  }) async {
    final open = await (_db.select(_db.activityIntervals)..where(
          (t) => t.sessionId.equals(sessionId) & t.endedAt.isNull(),
        ))
        .get();
    final already =
        activityId != null && open.any((o) => o.activityId == activityId);
    final toClose = activityId == null
        ? open
        : open.where((o) => o.activityId != activityId).toList();
    if (already && toClose.isEmpty) return;
    final now = DateTime.now();
    for (final interval in toClose) {
      await (_db.update(_db.activityIntervals)
            ..where((t) => t.id.equals(interval.id)))
          .write(ActivityIntervalsCompanion(endedAt: Value(now)));
    }
    if (activityId != null && !already) {
      await _db
          .into(_db.activityIntervals)
          .insert(
            ActivityIntervalsCompanion.insert(
              sessionId: sessionId,
              activityId: activityId,
              startedAt: now,
            ),
          );
    }
  }

  Stream<List<ReachZoneRecipeItem>> watchReachRecipes({int? protocolId}) {
    final pid = protocolId ?? this.protocolId;
    final query = _db.select(_db.reachZoneRecipes)
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    if (pid != null) {
      query.where((t) => t.protocolId.equals(pid));
    }
    return query.watch().map(
      (rows) => [for (final row in rows) _mapReachRecipe(row)],
    );
  }

  ReachZoneRecipeItem _mapReachRecipe(ReachZoneRecipe row) {
    return ReachZoneRecipeItem(
      id: row.id,
      protocolId: row.protocolId,
      joint: ReachJointInfo.fromStorage(row.joint),
      kind: ReachRecipeKindCodec.fromStorage(row.kind),
      validateAngle: row.validateAngle,
      zoneMin: row.zoneMin,
      zoneMax: row.zoneMax,
      colorValue: row.colorValue,
      sortOrder: row.sortOrder,
    );
  }

  Future<int> addReachRecipe({
    required ReachJoint joint,
    required ReachRecipeKind kind,
    double validateAngle = 90,
    double? zoneMin,
    double? zoneMax,
  }) async {
    final pid = protocolId;
    if (pid == null) {
      throw StateError('protocolId requis pour créer une zone');
    }
    final existing = await (_db.select(
      _db.reachZoneRecipes,
    )..where((t) => t.protocolId.equals(pid))).get();
    final color = subclassPalette[existing.length % subclassPalette.length];
    return _db.into(_db.reachZoneRecipes).insert(
      ReachZoneRecipesCompanion.insert(
        protocolId: pid,
        joint: joint.name,
        kind: kind.storageValue,
        validateAngle: Value(validateAngle),
        zoneMin: Value(zoneMin),
        zoneMax: Value(zoneMax),
        colorValue: color,
        sortOrder: existing.length,
      ),
    );
  }

  Future<void> updateReachRecipe({
    required int id,
    double? validateAngle,
    double? zoneMin,
    double? zoneMax,
  }) {
    return (_db.update(_db.reachZoneRecipes)..where((t) => t.id.equals(id))).write(
      ReachZoneRecipesCompanion(
        validateAngle:
            validateAngle == null ? const Value.absent() : Value(validateAngle),
        zoneMin: zoneMin == null ? const Value.absent() : Value(zoneMin),
        zoneMax: zoneMax == null ? const Value.absent() : Value(zoneMax),
      ),
    );
  }

  Future<void> deleteReachRecipe(int id) {
    return (_db.delete(_db.reachZoneRecipes)..where((t) => t.id.equals(id))).go();
  }

  Future<void> applyReachZone({
    required int sessionId,
    required int recipeId,
    required bool inZone,
  }) async {
    final open = await (_db.select(_db.reachZoneIntervals)..where(
          (t) =>
              t.sessionId.equals(sessionId) &
              t.recipeId.equals(recipeId) &
              t.endedAt.isNull(),
        ))
        .getSingleOrNull();
    if (inZone && open == null) {
      await _db.into(_db.reachZoneIntervals).insert(
        ReachZoneIntervalsCompanion.insert(
          sessionId: sessionId,
          recipeId: recipeId,
          startedAt: DateTime.now(),
        ),
      );
      return;
    }
    if (!inZone && open != null) {
      await (_db.update(_db.reachZoneIntervals)
            ..where((t) => t.id.equals(open.id)))
          .write(ReachZoneIntervalsCompanion(endedAt: Value(DateTime.now())));
    }
  }

  Future<void> deleteActivity(int id) {
    return (_db.delete(_db.learnedActivities)..where((t) => t.id.equals(id))).go();
  }

  Future<void> recordActivityEvent({
    required int sessionId,
    required int activityId,
  }) {
    return _db
        .into(_db.activityEvents)
        .insert(
          ActivityEventsCompanion.insert(
            sessionId: sessionId,
            activityId: activityId,
            occurredAt: DateTime.now(),
          ),
        );
  }

  Future<void> toggleActivityInterval({
    required int sessionId,
    required int activityId,
  }) async {
    final open = await (_db.select(_db.activityIntervals)
          ..where(
            (t) =>
                t.sessionId.equals(sessionId) &
                t.activityId.equals(activityId) &
                t.endedAt.isNull(),
          ))
        .getSingleOrNull();

    if (open != null) {
      await (_db.update(
        _db.activityIntervals,
      )..where((t) => t.id.equals(open.id))).write(
        ActivityIntervalsCompanion(endedAt: Value(DateTime.now())),
      );
      return;
    }

    await _db
        .into(_db.activityIntervals)
        .insert(
          ActivityIntervalsCompanion.insert(
            sessionId: sessionId,
            activityId: activityId,
            startedAt: DateTime.now(),
          ),
        );
  }

  Stream<SessionTimeline> watchLiveSession(int sessionId) {
    final session$ = (_db.select(_db.observationSessions)
          ..where((t) => t.id.equals(sessionId)))
        .watchSingle();

    return _switchMap(session$, (session) {
      final protocolName$ = session.protocolId == null
          ? Stream<String?>.value(null)
          : (_db.select(_db.observationProtocols)
                ..where((t) => t.id.equals(session.protocolId!)))
              .watch()
              .map((rows) => rows.isEmpty ? null : rows.first.name);

      return _combine2(
        _combine4(
          protocolName$,
          watchTaxonomy(protocolId: session.protocolId),
          watchActivities(protocolId: session.protocolId),
          _combine2(
            _combine2(
              (_db.select(
                _db.countEvents,
              )..where((t) => t.sessionId.equals(sessionId))).watch(),
              (_db.select(
                _db.activityEvents,
              )..where((t) => t.sessionId.equals(sessionId))).watch(),
              (counts, events) => (counts, events),
            ),
            _combine2(
              (_db.select(
                _db.durationIntervals,
              )..where((t) => t.sessionId.equals(sessionId))).watch(),
              (_db.select(
                _db.activityIntervals,
              )..where((t) => t.sessionId.equals(sessionId))).watch(),
              (durations, actIntervals) => (durations, actIntervals),
            ),
            (events, intervals) => (events, intervals),
          ),
          (protocolName, classes, activities, recorded) {
            return (protocolName, classes, activities, recorded);
          },
        ),
        _combine2(
          watchReachRecipes(protocolId: session.protocolId),
          (_db.select(_db.reachZoneIntervals)
                ..where((t) => t.sessionId.equals(sessionId)))
              .watch(),
          (recipes, zoneIntervals) => (recipes, zoneIntervals),
        ),
        (core, zones) {
          return SessionTimeline(
            session: SessionSummary(
              id: session.id,
              startedAt: session.startedAt,
              endedAt: session.endedAt,
              useManual: session.useManual,
              useReachZones: session.useReachZones,
              useActivity: session.useActivity,
              activityEngine: ActivityEngineKindCodec.fromStorage(
                session.activityEngine,
              ),
              protocolId: session.protocolId,
              protocolName: core.$1,
              userId: session.userId,
              name: session.name,
            ),
            classes: core.$2,
            activities: core.$3,
            countEvents: [
              for (final e in core.$4.$1.$1)
                CountEventItem(
                  id: e.id,
                  subclassId: e.subclassId,
                  occurredAt: e.occurredAt,
                ),
            ],
            activityEvents: [
              for (final e in core.$4.$1.$2)
                ActivityEventItem(
                  id: e.id,
                  activityId: e.activityId,
                  occurredAt: e.occurredAt,
                ),
            ],
            intervals: [
              for (final i in core.$4.$2.$1)
                DurationIntervalItem(
                  id: i.id,
                  subclassId: i.subclassId,
                  startedAt: i.startedAt,
                  endedAt: i.endedAt,
                ),
            ],
            activityIntervals: [
              for (final i in core.$4.$2.$2)
                ActivityIntervalItem(
                  id: i.id,
                  activityId: i.activityId,
                  startedAt: i.startedAt,
                  endedAt: i.endedAt,
                ),
            ],
            reachRecipes: zones.$1,
            reachIntervals: [
              for (final i in zones.$2)
                ReachZoneIntervalItem(
                  id: i.id,
                  recipeId: i.recipeId,
                  startedAt: i.startedAt,
                  endedAt: i.endedAt,
                ),
            ],
          );
        },
      );
    });
  }
}

List<ObservableClassItem> _mapTaxonomy(
  List<ObservableClassesData> classes,
  List<ObservableSubclassesData> subclasses,
) {
  return [
    for (final c in classes)
      ObservableClassItem(
        id: c.id,
        name: c.name,
        sortOrder: c.sortOrder,
        subclasses: [
          for (final s in subclasses.where((s) => s.classId == c.id))
            ObservableSubclassItem(
              id: s.id,
              classId: c.id,
              className: c.name,
              name: s.name,
              metricType: MetricKindCodec.fromStorage(s.metricType),
              colorValue: s.colorValue,
              sortOrder: s.sortOrder,
            ),
        ],
      ),
  ];
}

Stream<R> _combine2<A, B, R>(
  Stream<A> a,
  Stream<B> b,
  R Function(A, B) combine,
) {
  return _combine4<A, B, Object?, Object?, R>(
    a,
    b,
    Stream<Object?>.value(null),
    Stream<Object?>.value(null),
    (aa, bb, _, _) => combine(aa, bb),
  );
}

Stream<R> _combine4<A, B, C, D, R>(
  Stream<A> a,
  Stream<B> b,
  Stream<C> c,
  Stream<D> d,
  R Function(A, B, C, D) combine,
) {
  return Stream<R>.multi((listener) {
    A? latestA;
    B? latestB;
    C? latestC;
    D? latestD;
    var hasA = false;
    var hasB = false;
    var hasC = false;
    var hasD = false;

    void emit() {
      if (!hasA || !hasB || !hasC || !hasD) return;
      listener.add(combine(latestA as A, latestB as B, latestC as C, latestD as D));
    }

    final subs = <StreamSubscription<dynamic>>[
      a.listen((v) {
        latestA = v;
        hasA = true;
        emit();
      }, onError: listener.addError),
      b.listen((v) {
        latestB = v;
        hasB = true;
        emit();
      }, onError: listener.addError),
      c.listen((v) {
        latestC = v;
        hasC = true;
        emit();
      }, onError: listener.addError),
      d.listen((v) {
        latestD = v;
        hasD = true;
        emit();
      }, onError: listener.addError),
    ];

    listener
      ..onPause = () {
        for (final s in subs) {
          s.pause();
        }
      }
      ..onResume = () {
        for (final s in subs) {
          s.resume();
        }
      }
      ..onCancel = () {
        for (final s in subs) {
          s.cancel();
        }
      };
  });
}

Stream<R> _switchMap<T, R>(Stream<T> source, Stream<R> Function(T value) mapper) {
  return Stream<R>.multi((listener) {
    StreamSubscription<R>? inner;
    final outer = source.listen(
      (value) {
        inner?.cancel();
        inner = mapper(value).listen(
          listener.add,
          onError: listener.addError,
        );
      },
      onError: listener.addError,
      onDone: listener.close,
    );

    listener
      ..onPause = () {
        outer.pause();
        inner?.pause();
      }
      ..onResume = () {
        outer.resume();
        inner?.resume();
      }
      ..onCancel = () async {
        await inner?.cancel();
        await outer.cancel();
      };
  });
}
