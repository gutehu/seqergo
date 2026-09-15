import 'package:flutter_test/flutter_test.dart';
import 'package:seqergo/data/auth_repository.dart';
import 'package:seqergo/data/database.dart';
import 'package:seqergo/data/manual_repository.dart';
import 'package:seqergo/domain/activity_engine.dart';
import 'package:seqergo/domain/manual_models.dart';
import 'package:seqergo/domain/metric_kind.dart';
import 'package:seqergo/domain/reach_zone_models.dart';

void main() {
  late AppDatabase db;
  late AuthRepository auth;
  late ManualRepository repo;

  setUp(() async {
    db = AppDatabase.memory();
    auth = AuthRepository(db);
    final user = await auth.register(username: 'alice', password: 'secret1');
    final base = ManualRepository(db);
    final protocolId = await base.createProtocol(
      userId: user.id,
      name: 'Poste A',
      useManual: true,
      useReachZones: true,
      useActivity: true,
    );
    repo = ManualRepository(db, userId: user.id, protocolId: protocolId);
  });

  tearDown(() async {
    await db.close();
  });

  test('refuse un mauvais mot de passe', () async {
    expect(
      () => auth.login(username: 'alice', password: 'nope'),
      throwsA(isA<AuthException>()),
    );
  });

  test('classes, sous-classes, comptage et durée', () async {
    final classId = await repo.addClass('Membres supérieurs');
    final countId = await repo.addSubclass(
      classId: classId,
      name: 'Saisie',
      metricType: MetricKind.count,
    );
    final durationId = await repo.addSubclass(
      classId: classId,
      name: 'Maintien',
      metricType: MetricKind.duration,
    );

    final protocol = await repo.getProtocol(repo.protocolId!);
    expect(protocol, isNotNull);
    final sessionId = await repo.startSessionFromProtocol(protocol!);
    await repo.recordCount(sessionId: sessionId, subclassId: countId);
    await repo.recordCount(sessionId: sessionId, subclassId: countId);
    await repo.toggleDuration(sessionId: sessionId, subclassId: durationId);
    await Future<void>.delayed(const Duration(milliseconds: 30));
    await repo.toggleDuration(sessionId: sessionId, subclassId: durationId);
    await repo.endSession(sessionId);

    final timeline = await repo.watchLiveSession(sessionId).first;
    expect(timeline.countEvents, hasLength(2));
    expect(timeline.intervals, hasLength(1));
    expect(timeline.intervals.single.isOpen, isFalse);
    expect(timeline.classes.single.subclasses, hasLength(2));
    expect(timeline.lanes.any((l) => l.kind == ActographLaneKind.zone), isTrue);
  });

  test('durée d une activité sur la timeline et l actographe', () async {
    final activityId = await repo.addActivity(
      name: 'Serrage',
      clipPath: '/tmp/serrage.mp4',
    );
    final sessionId = await repo.startSession(
      useManual: false,
      useActivity: true,
    );
    await repo.toggleActivityInterval(
      sessionId: sessionId,
      activityId: activityId,
    );
    await Future<void>.delayed(const Duration(milliseconds: 30));
    await repo.toggleActivityInterval(
      sessionId: sessionId,
      activityId: activityId,
    );
    await repo.endSession(sessionId);

    final timeline = await repo.watchLiveSession(sessionId).first;
    expect(timeline.session.useActivity, isTrue);
    expect(timeline.activities, hasLength(1));
    expect(timeline.activityIntervals, hasLength(1));
    expect(timeline.activityIntervals.single.isOpen, isFalse);
    expect(timeline.activityIntervals.single.endedAt, isNotNull);
    expect(timeline.lanes.where((l) => l.kind == ActographLaneKind.activity), hasLength(1));
    expect(
      timeline.lanes.firstWhere((l) => l.kind == ActographLaneKind.activity).name,
      'Serrage',
    );
  });

  test('relance un protocole et isole les recettes', () async {
    final user = await auth.login(username: 'alice', password: 'secret1');
    final other = await repo.createProtocol(
      userId: user.id,
      name: 'Poste B',
      useManual: true,
      useReachZones: false,
      useActivity: false,
    );
    final otherRepo = ManualRepository(db, userId: user.id, protocolId: other);
    await otherRepo.addClass('Autre');

    await repo.addClass('Visible A');
    final protocols = await repo.watchProtocols(user.id).first;
    expect(protocols, hasLength(2));

    final original = protocols.firstWhere((p) => p.name == 'Poste A');
    final sessionId = await repo.startSessionFromProtocol(original);
    final timeline = await repo.watchLiveSession(sessionId).first;
    expect(timeline.session.protocolId, original.id);
    expect(timeline.classes.map((c) => c.name), contains('Visible A'));
    expect(timeline.classes.map((c) => c.name), isNot(contains('Autre')));
  });

  test('exemples KNN et détection exclusive sur la session', () async {
    final a = await repo.addActivity(name: 'Saisie', kind: 'visual');
    final b = await repo.addActivity(name: 'Attente', kind: 'visual');
    await repo.addEmbedding(activityId: a, vector: [1, 0, 0]);
    await repo.addEmbedding(activityId: a, vector: [0.9, 0.1, 0]);
    await repo.addEmbedding(activityId: b, vector: [0, 1, 0]);

    final knn = await repo.loadKnnClassifier();
    expect(knn.sampleCount(a), 2);
    expect(knn.predict([1, 0, 0])!.id, a);

    await repo.renameActivity(a, 'Prise de pièce');
    final renamed = await repo.watchActivities().first;
    expect(
      renamed.firstWhere((item) => item.id == a).name,
      'Prise de pièce',
    );

    final sessionId = await repo.startSession(
      useManual: false,
      useActivity: true,
      activityEngine: ActivityEngineKind.knn,
    );
    await repo.applyDetectedActivity(sessionId: sessionId, activityId: a);
    await repo.applyDetectedActivity(sessionId: sessionId, activityId: b);
    await repo.endSession(sessionId);

    final timeline = await repo.watchLiveSession(sessionId).first;
    expect(timeline.session.activityEngine, ActivityEngineKind.knn);
    expect(timeline.activities.map((e) => e.sampleCount), containsAll([2, 1]));
    expect(timeline.activityIntervals, hasLength(2));
    expect(timeline.activityIntervals.every((i) => !i.isOpen), isTrue);
  });

  test('sans reconnaissance aucune plage activité n est ouverte', () async {
    final activityId = await repo.addActivity(name: 'Saisie', kind: 'visual');
    final sessionId = await repo.startSession(
      useManual: false,
      useActivity: true,
      activityEngine: ActivityEngineKind.knn,
    );
    await repo.applyDetectedActivity(
      sessionId: sessionId,
      activityId: activityId,
    );
    await repo.applyDetectedActivity(sessionId: sessionId, activityId: null);
    await repo.endSession(sessionId);

    final timeline = await repo.watchLiveSession(sessionId).first;
    expect(timeline.activityIntervals, hasLength(1));
    expect(timeline.activityIntervals.single.isOpen, isFalse);
  });

  test('zones SEQOIA manuelles sur l actogramme', () async {
    final recipeId = await repo.addReachRecipe(
      joint: ReachJoint.epauleDroit,
      kind: ReachRecipeKind.validate,
      validateAngle: 90,
    );
    final sessionId = await repo.startSession(
      useManual: false,
      useReachZones: true,
      useActivity: false,
    );
    await repo.applyReachZone(
      sessionId: sessionId,
      recipeId: recipeId,
      inZone: true,
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));
    await repo.applyReachZone(
      sessionId: sessionId,
      recipeId: recipeId,
      inZone: false,
    );
    await repo.endSession(sessionId);

    final timeline = await repo.watchLiveSession(sessionId).first;
    expect(timeline.reachRecipes, hasLength(1));
    expect(timeline.reachRecipes.single.label, contains('Épaule'));
    expect(timeline.lanes.where((l) => l.kind == ActographLaneKind.zone), hasLength(1));
    expect(timeline.reachIntervals, hasLength(1));
    expect(timeline.reachIntervals.single.isOpen, isFalse);
  });

  test('un enregistrement peut être nommé pour les résultats', () async {
    final sessionId = await repo.startSession(
      useManual: true,
      useReachZones: false,
      useActivity: false,
    );
    await repo.endSession(sessionId);
    await repo.renameSession(sessionId, 'Opérateur A — matin');
    final sessions = await repo.watchSessions().first;
    expect(sessions.single.displayName, 'Opérateur A — matin');
    expect(sessions.single.name, 'Opérateur A — matin');
  });
}
