import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:speedometer/extensions/gilroy.dart';
import 'package:speedometer/constants/constants.dart';
import 'package:speedometer/speedometers/donut_speedometer/donut_speedometer_config.dart';

class DonutSpeedometerPaint extends CustomPainter {
  final Animation<double> animation;
  final double maxSpeed;
  final double initialValue;
  final DonutSpeedometerConfig config;

  DonutSpeedometerPaint({
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
    const endAngle = pi;
    const sweepAngle = endAngle - startAngle;

    // Draw the dial of the max value
    _paintDials(canvas, center, radius, startAngle, sweepAngle);

    // Draw needle
    // _paintNeedle(canvas, center, radius);

    // Draw progress digits
    _paintProgressDigits(canvas, center);

    // final Matrix4 matrix = Matrix4.rotationZ(animation.value);
    // needlePath = needlePath.transform(matrix.storage);
  }

  void _paintDials(
      Canvas canvas, Offset center, double radius, double startAngle, double sweepAngle) {
    const defaultColor = Color(0xFFEDEFF1);
    final dialPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.width
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = defaultColor;

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

    const currentDialStartAngle = -pi / 2;
    const total = pi * 2;
    final currentDialPaintEndAngle = currentDialStartAngle + (total * percentage);
    final currentDialPaintSweepAngle = currentDialPaintEndAngle - currentDialStartAngle;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      currentDialStartAngle,
      currentDialPaintSweepAngle,
      false,
      currentDialPaint,
    );
  }

  void _paintProgressDigits(Canvas canvas, Offset center) {
    final numberPaint = TextPainter(
      textScaleFactor: 1.3,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        children: [
          TextSpan(
              text: animation.value.toStringAsFixed(0),
              // "${animation.value.toStringAsFixed(0)}%",
              style: config.progressTextStyle),
          TextSpan(
            text: "\nof ${maxSpeed.toStringAsFixed(0)}",
            // "${animation.value.toStringAsFixed(0)}%",
            style: config.progressTextStyle,
          ),
        ],
        text: "",
      ),
    )..layout();
    numberPaint.paint(
        canvas, Offset(center.dx - numberPaint.width / 2, center.dy - numberPaint.height / 2.5));
  }

  @override
  bool shouldRepaint(covariant DonutSpeedometerPaint oldDelegate) {
    return oldDelegate.initialValue == initialValue;
  }
}
