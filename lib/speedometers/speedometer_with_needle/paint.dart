import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speedometer/config/config.dart';
import 'package:speedometer/speedometers/speedometer_with_needle/speedometer_with_needle_config.dart.dart';

import '../../constants/constants.dart';

class SpeedometerWithNeedlePainter extends CustomPainter {
  final Animation<double> animation;
  final double maxSpeed;
  final double initialValue;
  final SpeedometerConfig config;

  SpeedometerWithNeedlePainter({
    required this.animation,
    required this.maxSpeed,
    required this.initialValue,
    required this.config,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    const startAngle = -pi;
    const endAngle = 0.0;
    const sweepAngle = endAngle - startAngle;

    // Draw the dial of the max value
    _paintDials(canvas, center, radius, startAngle, sweepAngle);

    // Draw ticks
    _paintTicks(canvas, center, radius, startAngle, sweepAngle);

    // Draw needle
    _paintNeedle(canvas, center, radius);

    // Draw progress digits
    _paintProgressDigits(canvas, center);

    // final Matrix4 matrix = Matrix4.rotationZ(animation.value);
    // needlePath = needlePath.transform(matrix.storage);
  }

  void _paintDials(
      Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle) {
    final dialPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.width
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFEDEFF1);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      dialPaint,
    );

    // Draw the dial of the current value
    final currentDialPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.width
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final percentage = (animation.value / maxSpeed);

    if (config.colorType == SpeedometerColorType.gradient) {
      currentDialPaint.shader = LinearGradient(
        colors: config.colors,
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );
    } else {
      currentDialPaint.color = config.color ?? Colors.black;
    }

    const currentDialStartAngle = -pi;
    final currentDialPaintEndAngle = -pi + (pi * percentage);
    final currentDialPaintSweepAngle = currentDialPaintEndAngle - currentDialStartAngle;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      currentDialStartAngle,
      currentDialPaintSweepAngle,
      false,
      currentDialPaint,
    );
  }

  void _paintTicks(
      Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle) {
    // Draw the tick marks and labels
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..color = Colors.grey.shade300;

    const tickCount = 30;
    final tickSpacing = sweepAngle / tickCount;

    for (int i = 0; i <= tickCount; i++) {
      final tickAngle = startAngle + i * tickSpacing;
      const tickLength = 10;
      const divisionFactor = 1.45;
      final tickStart = center +
          Offset(cos(tickAngle) / divisionFactor, sin(tickAngle) / divisionFactor) *
              (radius - tickLength);
      final tickEnd = center +
          Offset(cos(tickAngle) / divisionFactor, sin(tickAngle) / divisionFactor) * (radius - 5);

      canvas.drawLine(tickStart, tickEnd, tickPaint);

      if (i % 2 == 0) {
        // ignore: unused_local_variable
        Offset offset = Offset.zero;
        final half = (tickCount / 2).round();

        if (i == 0) {
          offset = const Offset(0, 0);
        } else if (i == tickCount) {
          offset = const Offset(5, 0);
        } else if (i < half) {
          offset = const Offset(-5, -5);
        } else if (i > half) {
          offset = const Offset(5, -5);
        } else if (i == half) {
          offset = const Offset(0, -5);
        }
      }
    }
  }

  void _paintNeedle(Canvas canvas, Offset center, double radius) {
    final needlePaint = Paint()
      ..color = (config as SpeedometerWithNeedleConfig).needleColor
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    Path needlePath = Path()
      ..moveTo(center.dx, center.dy - radius + 25)
      ..lineTo(center.dx - 6, center.dy)
      ..arcToPoint(
        Offset(center.dx + 15, center.dy),
        radius: const Radius.circular(1),
        largeArc: false,
        clockwise: false,
      )
      ..lineTo(center.dx + 6, center.dy - radius + 25)
      ..arcToPoint(
        Offset(center.dx, center.dy - radius + 25),
        radius: const Radius.circular(1),
        largeArc: false,
        clockwise: false,
      );

    final percentage = (animation.value / maxSpeed);
    final currentDialPaintEndAngle = -pi + (pi * percentage);

    final notchOffset = Offset(center.dx + 5, center.dy - 2);
    final notchPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = (config as SpeedometerWithNeedleConfig).notchColor;

    canvas.save();
    canvas.translate(center.dx + 5, center.dy - 2);
    canvas.rotate(currentDialPaintEndAngle + pi / 2);
    canvas.translate(-center.dx - 5, -center.dy + 2);
    canvas.drawPath(needlePath, needlePaint);
    canvas.drawCircle(notchOffset, 5, notchPaint);
    canvas.restore();
  }

  void _paintProgressDigits(Canvas canvas, Offset center) {
    final config = this.config as SpeedometerWithNeedleConfig;
    final numberPaint = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(text: "", children: [
        TextSpan(text: animation.value.toStringAsFixed(0), style: config.progressTextStyle),
        TextSpan(
          text: "/",
          style: config.progressTextStyle,
        ),
        TextSpan(
          text: maxSpeed.toStringAsFixed(0),
          style: config.maxValueTextStyle,
        ),
      ]),
    )..layout();
    final numberOffset =
        Offset(center.dx - numberPaint.width / 2, center.dy + numberPaint.height / 2);

    numberPaint.paint(canvas, numberOffset);
  }

  @override
  bool shouldRepaint(covariant SpeedometerWithNeedlePainter oldDelegate) {
    return oldDelegate.initialValue == initialValue;
  }
}
