import 'dart:math' as math;

import '../domain/reach_zone_models.dart';

class JointPoint {
  const JointPoint(this.x, this.y);
  final double x;
  final double y;
}

class BodyPoints {
  const BodyPoints({
    this.leftHip,
    this.rightHip,
    this.leftKnee,
    this.rightKnee,
    this.leftAnkle,
    this.rightAnkle,
    this.leftShoulder,
    this.rightShoulder,
    this.leftElbow,
    this.rightElbow,
    this.leftWrist,
    this.rightWrist,
  });

  final JointPoint? leftHip;
  final JointPoint? rightHip;
  final JointPoint? leftKnee;
  final JointPoint? rightKnee;
  final JointPoint? leftAnkle;
  final JointPoint? rightAnkle;
  final JointPoint? leftShoulder;
  final JointPoint? rightShoulder;
  final JointPoint? leftElbow;
  final JointPoint? rightElbow;
  final JointPoint? leftWrist;
  final JointPoint? rightWrist;

  JointPoint? hip(ReachSide side) =>
      side == ReachSide.gauche ? leftHip : rightHip;
  JointPoint? knee(ReachSide side) =>
      side == ReachSide.gauche ? leftKnee : rightKnee;
  JointPoint? ankle(ReachSide side) =>
      side == ReachSide.gauche ? leftAnkle : rightAnkle;
  JointPoint? shoulder(ReachSide side) =>
      side == ReachSide.gauche ? leftShoulder : rightShoulder;
  JointPoint? elbow(ReachSide side) =>
      side == ReachSide.gauche ? leftElbow : rightElbow;
  JointPoint? wrist(ReachSide side) =>
      side == ReachSide.gauche ? leftWrist : rightWrist;
}

/// Angle au sommet [b], en degrés, entre [a]–[b]–[c] (même formule que SEQOIA).
double? angle3Points(JointPoint? a, JointPoint? b, JointPoint? c) {
  if (a == null || b == null || c == null) return null;
  final v1x = a.x - b.x, v1y = a.y - b.y;
  final v2x = c.x - b.x, v2y = c.y - b.y;
  final n1 = math.sqrt(v1x * v1x + v1y * v1y);
  final n2 = math.sqrt(v2x * v2x + v2y * v2y);
  if (n1 < 1e-6 || n2 < 1e-6) return null;
  final cosA = ((v1x * v2x + v1y * v2y) / (n1 * n2)).clamp(-1.0, 1.0);
  return math.acos(cosA) * 180 / math.pi;
}

double? angleForJoint(ReachJoint joint, BodyPoints body) {
  final side = joint.side;
  return switch (joint.family) {
    ReachJointFamily.genou =>
      angle3Points(body.hip(side), body.knee(side), body.ankle(side)),
    ReachJointFamily.hanche =>
      angle3Points(body.shoulder(side), body.hip(side), body.knee(side)),
    ReachJointFamily.epaule =>
      angle3Points(body.hip(side), body.shoulder(side), body.elbow(side)),
    ReachJointFamily.coude =>
      angle3Points(body.shoulder(side), body.elbow(side), body.wrist(side)),
  };
}
