import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:seqergo/domain/reach_zone_models.dart';
import 'package:seqergo/vision/clip_client.dart';
import 'package:seqergo/vision/detection_smoother.dart';
import 'package:seqergo/vision/joint_angles.dart';
import 'package:seqergo/vision/knn_classifier.dart';
import 'package:seqergo/vision/pose_overlay_mapper.dart';
import 'package:seqergo/vision/reach_zone_engine.dart';

void main() {
  test('KNN sépare deux classes d embeddings', () {
    final knn = KnnClassifier();
    knn.add(id: 1, label: 'Saisie', embedding: [1, 0, 0, 0]);
    knn.add(id: 1, label: 'Saisie', embedding: [0.9, 0.1, 0, 0]);
    knn.add(id: 2, label: 'Attente', embedding: [0, 0, 1, 0]);
    knn.add(id: 2, label: 'Attente', embedding: [0, 0.1, 0.9, 0]);

    final saisie = knn.predict([1, 0, 0, 0])!;
    final attente = knn.predict([0, 0, 1, 0])!;
    expect(saisie.label, 'Saisie');
    expect(attente.label, 'Attente');
    expect(saisie.confidence, greaterThan(0.5));
  });

  test('un seul modèle KNN suffit et ignore une scène trop loin', () {
    final knn = KnnClassifier();
    knn.add(id: 1, label: 'Saisie', embedding: [1, 0, 0, 0]);
    knn.add(id: 1, label: 'Saisie', embedding: [0.95, 0.05, 0, 0]);
    expect(knn.predict([0.98, 0.02, 0, 0])?.id, 1);
    expect(knn.predict([0, 0, 0, 1]), isNull);
  });

  test('CLIP n enregistre que si un modèle entraîné gagne', () {
    expect(
      ClipClient.recognizedLabel(
        const ClipFrameResult(
          label: ClipClient.unknownLabel,
          confidence: 0.9,
          scores: [],
        ),
        ['Saisie'],
      ),
      isNull,
    );
    expect(
      ClipClient.recognizedLabel(
        const ClipFrameResult(label: 'Saisie', confidence: 0.8, scores: []),
        ['Saisie', 'Attente'],
      ),
      'Saisie',
    );
  });

  test('le lissage ignore un clignotement trop court', () {
    final smoother = DetectionSmoother(
      windowSize: 3,
      minHold: const Duration(milliseconds: 400),
      minConfidence: 0.3,
    );
    final t0 = DateTime(2026, 1, 1);
    smoother.update(now: t0, id: 1, label: 'A', confidence: 0.9);
    smoother.update(
      now: t0.add(const Duration(milliseconds: 50)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    final early = smoother.update(
      now: t0.add(const Duration(milliseconds: 80)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    expect(early.id, isNull);

    final held = smoother.update(
      now: t0.add(const Duration(milliseconds: 500)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    expect(held.id, 1);
    expect(held.label, 'A');
  });

  test('le lissage par défaut valide en 180 ms', () {
    final smoother = DetectionSmoother();
    final t0 = DateTime(2026, 1, 1);
    smoother.update(now: t0, id: 1, label: 'A', confidence: 0.9);
    smoother.update(
      now: t0.add(const Duration(milliseconds: 40)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    final early = smoother.update(
      now: t0.add(const Duration(milliseconds: 80)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    expect(early.id, isNull);

    final held = smoother.update(
      now: t0.add(const Duration(milliseconds: 180)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    expect(held.id, 1);
  });

  test('le lissage relâche une activité non reconnue', () {
    final smoother = DetectionSmoother(
      windowSize: 3,
      minHold: const Duration(milliseconds: 180),
      minConfidence: 0.3,
    );
    final t0 = DateTime(2026, 1, 1);
    smoother.update(now: t0, id: 1, label: 'A', confidence: 0.9);
    smoother.update(
      now: t0.add(const Duration(milliseconds: 40)),
      id: 1,
      label: 'A',
      confidence: 0.9,
    );
    expect(
      smoother
          .update(
            now: t0.add(const Duration(milliseconds: 180)),
            id: 1,
            label: 'A',
            confidence: 0.9,
          )
          .id,
      1,
    );
    smoother.update(
      now: t0.add(const Duration(milliseconds: 200)),
      id: null,
      label: null,
      confidence: 0,
    );
    smoother.update(
      now: t0.add(const Duration(milliseconds: 240)),
      id: null,
      label: null,
      confidence: 0,
    );
    smoother.update(
      now: t0.add(const Duration(milliseconds: 280)),
      id: null,
      label: null,
      confidence: 0,
    );
    final released = smoother.update(
      now: t0.add(const Duration(milliseconds: 460)),
      id: null,
      label: null,
      confidence: 0,
    );
    expect(released.id, isNull);
  });

  test('angle SEQOIA au genou à 90°', () {
    const hip = JointPoint(0, 0);
    const knee = JointPoint(0, 1);
    const ankle = JointPoint(1, 1);
    final left = angleForJoint(
      ReachJoint.genouGauche,
      const BodyPoints(leftHip: hip, leftKnee: knee, leftAnkle: ankle),
    );
    final right = angleForJoint(
      ReachJoint.genouDroit,
      const BodyPoints(rightHip: hip, rightKnee: knee, rightAnkle: ankle),
    );
    expect(left, closeTo(90, 0.01));
    expect(right, closeTo(90, 0.01));
  });

  test('gauche et droite sont des observables distincts', () {
    const left = JointPoint(0, 0);
    const mid = JointPoint(0, 1);
    const right90 = JointPoint(1, 1);
    const straight = JointPoint(0, 2);
    final body = BodyPoints(
      leftHip: left,
      leftKnee: mid,
      leftAnkle: right90,
      rightHip: left,
      rightKnee: mid,
      rightAnkle: straight,
    );
    expect(angleForJoint(ReachJoint.genouGauche, body), closeTo(90, 0.01));
    expect(angleForJoint(ReachJoint.genouDroit, body), closeTo(180, 0.01));
  });

  test('une zone SEQOIA s ouvre et se ferme', () {
    const recipe = ReachZoneRecipeItem(
      id: 1,
      protocolId: 1,
      joint: ReachJoint.epauleDroit,
      kind: ReachRecipeKind.validate,
      validateAngle: 90,
      colorValue: 0xFF4F46E5,
      sortOrder: 0,
    );
    final engine = ReachZoneEngine([recipe], hysteresisDeg: 2);
    expect(engine.update({ReachJoint.epauleDroit: 80}), isEmpty);
    expect(engine.update({ReachJoint.epauleDroit: 91})[1], isTrue);
    expect(engine.update({ReachJoint.epauleDroit: 89}), isEmpty);
    expect(engine.update({ReachJoint.epauleDroit: 87})[1], isFalse);
  });

  test('mapping pose Android 90° aligne le canvas portrait', () {
    const canvas = Size(480, 640);
    const image = Size(640, 480);
    final origin = mapPoseLandmark(
      x: 0,
      y: 0,
      canvasSize: canvas,
      imageSize: image,
      rotationDeg: 90,
    );
    final corner = mapPoseLandmark(
      x: 480,
      y: 640,
      canvasSize: canvas,
      imageSize: image,
      rotationDeg: 90,
    );
    expect(origin, Offset.zero);
    expect(corner.dx, closeTo(480, 0.01));
    expect(corner.dy, closeTo(640, 0.01));
  });

  test('les anciennes recettes sans côté deviennent le droit', () {
    expect(ReachJointInfo.fromStorage('epaule'), ReachJoint.epauleDroit);
    expect(ReachJointInfo.fromStorage('genouGauche'), ReachJoint.genouGauche);
  });

  test('une zone SEQOIA colore le bon côté', () {
    expect(vertexForJoint(ReachJoint.genouDroit), PoseLandmarkType.rightKnee);
    expect(vertexForJoint(ReachJoint.epauleGauche), PoseLandmarkType.leftShoulder);
    expect(
      bonesForJoint(ReachJoint.coudeDroit),
      contains(
        (PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist),
      ),
    );
    expect(
      bonesForJoint(ReachJoint.coudeGauche),
      contains(
        (PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist),
      ),
    );
  });
}
