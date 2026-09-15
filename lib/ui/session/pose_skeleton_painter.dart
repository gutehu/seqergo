import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../../domain/reach_zone_models.dart';
import '../../vision/pose_overlay_mapper.dart';

class PoseOverlayFrame {
  const PoseOverlayFrame({
    required this.imageSize,
    required this.rotationDeg,
    required this.mirrorX,
    required this.isIos,
    required this.points,
    this.observedJoints = const {},
    required this.activeJoints,
  });

  final Size imageSize;
  final int rotationDeg;
  final bool mirrorX;
  final bool isIos;
  final Map<PoseLandmarkType, Offset> points;
  final Set<ReachJoint> observedJoints;
  final Set<ReachJoint> activeJoints;
}

class PoseSkeletonPainter extends CustomPainter {
  PoseSkeletonPainter(this.frame);

  final PoseOverlayFrame frame;

  static const _white = Color(0xFFFFFFFF);
  static const _green = Color(0xFF22C55E);
  static const _left = Color(0xFF38BDF8);
  static const _right = Color(0xFFFB923C);

  @override
  void paint(Canvas canvas, Size size) {
    Offset? at(PoseLandmarkType type) {
      final raw = frame.points[type];
      if (raw == null) return null;
      return mapPoseLandmark(
        x: raw.dx,
        y: raw.dy,
        canvasSize: size,
        imageSize: frame.imageSize,
        rotationDeg: frame.rotationDeg,
        isIos: frame.isIos,
        mirrorX: frame.mirrorX,
      );
    }

    final outline = Paint()
      ..color = const Color(0xCC0F172A)
      ..strokeWidth = 6.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final whiteStroke = Paint()
      ..color = _white
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final leftStroke = Paint()
      ..color = _left
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final rightStroke = Paint()
      ..color = _right
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final greenStroke = Paint()
      ..color = _green
      ..strokeWidth = 6.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final whiteFill = Paint()
      ..color = _white
      ..style = PaintingStyle.fill;
    final leftFill = Paint()
      ..color = _left
      ..style = PaintingStyle.fill;
    final rightFill = Paint()
      ..color = _right
      ..style = PaintingStyle.fill;
    final greenFill = Paint()
      ..color = _green
      ..style = PaintingStyle.fill;

    void drawBone(
      PoseLandmarkType a,
      PoseLandmarkType b,
      Paint paint,
    ) {
      final pa = at(a);
      final pb = at(b);
      if (pa == null || pb == null) return;
      canvas.drawLine(pa, pb, paint);
    }

    for (final bone in poseBones) {
      drawBone(bone.$1, bone.$2, outline);
    }
    for (final bone in poseBones) {
      drawBone(bone.$1, bone.$2, whiteStroke);
    }

    final landmarkColor = <PoseLandmarkType, Color>{};

    void paintJointSet(Set<ReachJoint> joints, Paint stroke, Color fill) {
      for (final joint in joints) {
        for (final bone in bonesForJoint(joint)) {
          drawBone(bone.$1, bone.$2, stroke);
          landmarkColor[bone.$1] = fill;
          landmarkColor[bone.$2] = fill;
        }
        landmarkColor[vertexForJoint(joint)] = fill;
      }
    }

    final idleLeft = {
      for (final j in frame.observedJoints)
        if (j.side == ReachSide.gauche && !frame.activeJoints.contains(j)) j,
    };
    final idleRight = {
      for (final j in frame.observedJoints)
        if (j.side == ReachSide.droit && !frame.activeJoints.contains(j)) j,
    };
    paintJointSet(idleLeft, leftStroke, _left);
    paintJointSet(idleRight, rightStroke, _right);
    paintJointSet(frame.activeJoints, greenStroke, _green);

    for (final entry in frame.points.keys) {
      final p = at(entry);
      if (p == null) continue;
      final color = landmarkColor[entry];
      canvas.drawCircle(
        p,
        color == _green ? 7 : (color == null ? 3.4 : 5.5),
        color == null
            ? whiteFill
            : color == _green
                ? greenFill
                : color == _left
                    ? leftFill
                    : rightFill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant PoseSkeletonPainter oldDelegate) =>
      oldDelegate.frame != frame;
}
