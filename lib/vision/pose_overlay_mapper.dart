import 'dart:ui';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../domain/reach_zone_models.dart';

/// Landmark ML Kit → canvas, même formule que l’exemple google_mlkit.
Offset mapPoseLandmark({
  required double x,
  required double y,
  required Size canvasSize,
  required Size imageSize,
  required int rotationDeg,
  bool isIos = false,
  bool mirrorX = false,
}) {
  if (canvasSize.width <= 0 ||
      canvasSize.height <= 0 ||
      imageSize.width <= 0 ||
      imageSize.height <= 0) {
    return Offset.zero;
  }
  final rot = ((rotationDeg % 360) + 360) % 360;
  final double mappedX;
  final double mappedY;
  switch (rot) {
    case 90:
      mappedX = x *
          canvasSize.width /
          (isIos ? imageSize.width : imageSize.height);
      mappedY = y *
          canvasSize.height /
          (isIos ? imageSize.height : imageSize.width);
    case 270:
      mappedX = canvasSize.width -
          x *
              canvasSize.width /
              (isIos ? imageSize.width : imageSize.height);
      mappedY = y *
          canvasSize.height /
          (isIos ? imageSize.height : imageSize.width);
    default:
      mappedX = x * canvasSize.width / imageSize.width;
      mappedY = y * canvasSize.height / imageSize.height;
  }
  return Offset(
    mirrorX ? canvasSize.width - mappedX : mappedX,
    mappedY,
  );
}

/// Os du squelette MediaPipe (33 points).
const poseBones = <(PoseLandmarkType, PoseLandmarkType)>[
  (PoseLandmarkType.nose, PoseLandmarkType.leftEyeInner),
  (PoseLandmarkType.leftEyeInner, PoseLandmarkType.leftEye),
  (PoseLandmarkType.leftEye, PoseLandmarkType.leftEyeOuter),
  (PoseLandmarkType.leftEyeOuter, PoseLandmarkType.leftEar),
  (PoseLandmarkType.nose, PoseLandmarkType.rightEyeInner),
  (PoseLandmarkType.rightEyeInner, PoseLandmarkType.rightEye),
  (PoseLandmarkType.rightEye, PoseLandmarkType.rightEyeOuter),
  (PoseLandmarkType.rightEyeOuter, PoseLandmarkType.rightEar),
  (PoseLandmarkType.leftMouth, PoseLandmarkType.rightMouth),
  (PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder),
  (PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip),
  (PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip),
  (PoseLandmarkType.leftHip, PoseLandmarkType.rightHip),
  (PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow),
  (PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist),
  (PoseLandmarkType.leftWrist, PoseLandmarkType.leftThumb),
  (PoseLandmarkType.leftWrist, PoseLandmarkType.leftIndex),
  (PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinky),
  (PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow),
  (PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist),
  (PoseLandmarkType.rightWrist, PoseLandmarkType.rightThumb),
  (PoseLandmarkType.rightWrist, PoseLandmarkType.rightIndex),
  (PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinky),
  (PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee),
  (PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle),
  (PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel),
  (PoseLandmarkType.leftAnkle, PoseLandmarkType.leftFootIndex),
  (PoseLandmarkType.leftHeel, PoseLandmarkType.leftFootIndex),
  (PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee),
  (PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle),
  (PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel),
  (PoseLandmarkType.rightAnkle, PoseLandmarkType.rightFootIndex),
  (PoseLandmarkType.rightHeel, PoseLandmarkType.rightFootIndex),
];

/// Segments mesurés pour une articulation (gauche ou droite).
List<(PoseLandmarkType, PoseLandmarkType)> bonesForJoint(ReachJoint joint) {
  final left = joint.side == ReachSide.gauche;
  return switch (joint.family) {
    ReachJointFamily.genou => [
        (
          left ? PoseLandmarkType.leftHip : PoseLandmarkType.rightHip,
          left ? PoseLandmarkType.leftKnee : PoseLandmarkType.rightKnee,
        ),
        (
          left ? PoseLandmarkType.leftKnee : PoseLandmarkType.rightKnee,
          left ? PoseLandmarkType.leftAnkle : PoseLandmarkType.rightAnkle,
        ),
      ],
    ReachJointFamily.hanche => [
        (
          left
              ? PoseLandmarkType.leftShoulder
              : PoseLandmarkType.rightShoulder,
          left ? PoseLandmarkType.leftHip : PoseLandmarkType.rightHip,
        ),
        (
          left ? PoseLandmarkType.leftHip : PoseLandmarkType.rightHip,
          left ? PoseLandmarkType.leftKnee : PoseLandmarkType.rightKnee,
        ),
      ],
    ReachJointFamily.epaule => [
        (
          left ? PoseLandmarkType.leftHip : PoseLandmarkType.rightHip,
          left
              ? PoseLandmarkType.leftShoulder
              : PoseLandmarkType.rightShoulder,
        ),
        (
          left
              ? PoseLandmarkType.leftShoulder
              : PoseLandmarkType.rightShoulder,
          left ? PoseLandmarkType.leftElbow : PoseLandmarkType.rightElbow,
        ),
      ],
    ReachJointFamily.coude => [
        (
          left
              ? PoseLandmarkType.leftShoulder
              : PoseLandmarkType.rightShoulder,
          left ? PoseLandmarkType.leftElbow : PoseLandmarkType.rightElbow,
        ),
        (
          left ? PoseLandmarkType.leftElbow : PoseLandmarkType.rightElbow,
          left ? PoseLandmarkType.leftWrist : PoseLandmarkType.rightWrist,
        ),
      ],
  };
}

PoseLandmarkType vertexForJoint(ReachJoint joint) {
  final left = joint.side == ReachSide.gauche;
  return switch (joint.family) {
    ReachJointFamily.genou =>
      left ? PoseLandmarkType.leftKnee : PoseLandmarkType.rightKnee,
    ReachJointFamily.hanche =>
      left ? PoseLandmarkType.leftHip : PoseLandmarkType.rightHip,
    ReachJointFamily.epaule =>
      left ? PoseLandmarkType.leftShoulder : PoseLandmarkType.rightShoulder,
    ReachJointFamily.coude =>
      left ? PoseLandmarkType.leftElbow : PoseLandmarkType.rightElbow,
  };
}
