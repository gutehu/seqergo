import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/database_scope.dart';
import '../../data/manual_repository.dart';
import '../../domain/manual_models.dart';
import 'time_format.dart';

class ActographScreen extends StatefulWidget {
  const ActographScreen({super.key, required this.sessionId});

  final int sessionId;

  @override
  State<ActographScreen> createState() => _ActographScreenState();
}

class _ActographScreenState extends State<ActographScreen> {
  Timer? _ticker;
  late Stream<SessionTimeline> _session;
  var _ready = false;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 250), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _session = ManualRepository(DatabaseScope.of(context))
        .watchLiveSession(widget.sessionId);
    _ready = true;
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SessionTimeline>(
      stream: _session,
      builder: (context, snapshot) {
        final data = snapshot.data;
        return Scaffold(
          appBar: AppBar(title: const Text('Actogramme')),
          body: data == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.session.displayName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            [
                              if (data.session.protocolName != null &&
                                  data.session.protocolName !=
                                      data.session.displayName)
                                data.session.protocolName!,
                              'Début ${formatSessionStamp(data.session.startedAt)}',
                              if (data.session.endedAt != null)
                                'fin ${formatClock(data.session.endedAt!)}'
                              else
                                'en cours',
                              data.session.modeLabel,
                            ].join(' · '),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          for (final lane in data.lanes)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: lane.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${lane.name} · ${lane.sourceLabel}',
                                    ),
                                  ),
                                  Text(
                                    _laneMetric(data, lane, DateTime.now()),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFeatures: [FontFeature.tabularFigures()],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: data.lanes.isEmpty
                          ? const Center(child: Text('Aucune nageoire à afficher.'))
                          : ActographView(timeline: data, now: DateTime.now()),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

String _laneMetric(SessionTimeline data, ActographLane lane, DateTime now) {
  if (lane.kind == ActographLaneKind.activity && lane.activityId != null) {
    return formatElapsed(data.activityElapsed(lane.activityId!, now));
  }
  if (lane.kind == ActographLaneKind.duration && lane.subclassId != null) {
    return formatElapsed(data.subclassElapsed(lane.subclassId!, now));
  }
  if (lane.kind == ActographLaneKind.count && lane.subclassId != null) {
    return '× ${data.subclassCount(lane.subclassId!)}';
  }
  if (lane.kind == ActographLaneKind.zone && lane.recipeId != null) {
    return formatElapsed(data.reachElapsed(lane.recipeId!, now));
  }
  if (lane.kind == ActographLaneKind.zone) {
    return 'à brancher';
  }
  return '';
}

class ActographView extends StatelessWidget {
  const ActographView({
    super.key,
    required this.timeline,
    required this.now,
  });

  final SessionTimeline timeline;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final lanes = timeline.lanes;
    const rowHeight = 44.0;
    const labelWidth = 132.0;
    final chartHeight = math.max(180.0, lanes.length * rowHeight + 48);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.max(constraints.maxWidth, 640.0);
        return SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: width,
              height: chartHeight,
              child: CustomPaint(
                painter: ActographPainter(
                  timeline: timeline,
                  now: now,
                  labelWidth: labelWidth,
                  rowHeight: rowHeight,
                ),
                size: Size(width, chartHeight),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ActographPainter extends CustomPainter {
  ActographPainter({
    required this.timeline,
    required this.now,
    required this.labelWidth,
    required this.rowHeight,
  });

  final SessionTimeline timeline;
  final DateTime now;
  final double labelWidth;
  final double rowHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final start = timeline.session.startedAt;
    final end = timeline.session.endedAt ?? now;
    var spanMs = end.difference(start).inMilliseconds.toDouble();
    if (spanMs < 1000) spanMs = 1000;
    final lanes = timeline.lanes;
    final plotWidth = size.width - labelWidth - 16;
    final plotLeft = labelWidth;

    final axisPaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..strokeWidth = 1;
    final text = TextPainter(textDirection: TextDirection.ltr);

    canvas.drawLine(
      Offset(plotLeft, 28),
      Offset(size.width - 8, 28),
      axisPaint,
    );

    const ticks = 6;
    for (var i = 0; i <= ticks; i++) {
      final t = i / ticks;
      final x = plotLeft + plotWidth * t;
      canvas.drawLine(Offset(x, 24), Offset(x, size.height - 8), axisPaint);
      final labelTime = start.add(Duration(milliseconds: (spanMs * t).round()));
      text.text = TextSpan(
        text: formatClock(labelTime),
        style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
      );
      text.layout();
      text.paint(canvas, Offset(x - text.width / 2, 6));
    }

    for (var i = 0; i < lanes.length; i++) {
      final lane = lanes[i];
      final top = 36 + i * rowHeight;

      text.text = TextSpan(
        text: lane.recipeId != null
            ? '${lane.name}\n${formatElapsed(timeline.reachElapsed(lane.recipeId!, now))}'
            : lane.activityId != null
            ? '${lane.name}\n${formatElapsed(timeline.activityElapsed(lane.activityId!, now))}'
            : '${lane.name}\n${lane.sourceLabel}',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0F172A),
          height: 1.15,
        ),
      );
      text.layout(maxWidth: labelWidth - 12);
      text.paint(canvas, Offset(8, top + 6));

      final midY = top + rowHeight / 2;
      canvas.drawLine(
        Offset(plotLeft, midY),
        Offset(size.width - 8, midY),
        Paint()
          ..color = const Color(0xFFE2E8F0)
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round,
      );

      final color = lane.color;

      if (lane.kind == ActographLaneKind.duration && lane.subclassId != null) {
        for (final interval in timeline.intervals.where((e) => e.subclassId == lane.subclassId)) {
          final x1 = _x(interval.startedAt, start, spanMs, plotLeft, plotWidth);
          final x2 = _x(interval.endedAt ?? now, start, spanMs, plotLeft, plotWidth);
          final rect = RRect.fromLTRBR(
            math.min(x1, x2),
            midY - 9,
            math.max(x1 + 4, x2),
            midY + 9,
            const Radius.circular(6),
          );
          canvas.drawRRect(rect, Paint()..color = color);
        }
      } else if (lane.kind == ActographLaneKind.count && lane.subclassId != null) {
        for (final event in timeline.countEvents.where((e) => e.subclassId == lane.subclassId)) {
          final x = _x(event.occurredAt, start, spanMs, plotLeft, plotWidth);
          canvas.drawCircle(Offset(x, midY), 5, Paint()..color = color);
        }
      } else if (lane.kind == ActographLaneKind.zone && lane.recipeId != null) {
        for (final interval in timeline.reachIntervals.where((e) => e.recipeId == lane.recipeId)) {
          final x1 = _x(interval.startedAt, start, spanMs, plotLeft, plotWidth);
          final x2 = _x(interval.endedAt ?? now, start, spanMs, plotLeft, plotWidth);
          final rect = RRect.fromLTRBR(
            math.min(x1, x2),
            midY - 9,
            math.max(x1 + 4, x2),
            midY + 9,
            const Radius.circular(6),
          );
          canvas.drawRRect(rect, Paint()..color = color);
        }
      } else if (lane.kind == ActographLaneKind.zone) {
        final paint = Paint()
          ..color = color.withValues(alpha: 0.35)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;
        canvas.drawRRect(
          RRect.fromLTRBR(
            plotLeft,
            midY - 8,
            size.width - 8,
            midY + 8,
            const Radius.circular(6),
          ),
          paint,
        );
      } else if (lane.kind == ActographLaneKind.activity && lane.activityId != null) {
        for (final interval in timeline.activityIntervals.where((e) => e.activityId == lane.activityId)) {
          final x1 = _x(interval.startedAt, start, spanMs, plotLeft, plotWidth);
          final x2 = _x(interval.endedAt ?? now, start, spanMs, plotLeft, plotWidth);
          final rect = RRect.fromLTRBR(
            math.min(x1, x2),
            midY - 9,
            math.max(x1 + 4, x2),
            midY + 9,
            const Radius.circular(6),
          );
          canvas.drawRRect(rect, Paint()..color = color);
        }
        for (final event in timeline.activityEvents.where((e) => e.activityId == lane.activityId)) {
          final x = _x(event.occurredAt, start, spanMs, plotLeft, plotWidth);
          canvas.drawCircle(Offset(x, midY), 5, Paint()..color = color);
        }
      }
    }
  }

  double _x(DateTime t, DateTime start, double spanMs, double left, double width) {
    final p = (t.difference(start).inMilliseconds / spanMs).clamp(0.0, 1.0);
    return left + width * p;
  }

  @override
  bool shouldRepaint(covariant ActographPainter oldDelegate) {
    return oldDelegate.timeline != timeline || oldDelegate.now != now;
  }
}
