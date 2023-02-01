// part of speedometer;

import 'package:flutter/material.dart';
import 'package:speedometer/config/config.dart';
import 'package:speedometer/core/speedometer.dart';
import 'package:speedometer/speedometers/speedometer_with_needle/paint.dart';
import 'package:speedometer/speedometers/speedometer_with_needle/speedometer_with_needle_config.dart.dart';

final SpeedometerConfig defaultSpeedometerWithNeedleConfig = SpeedometerWithNeedleConfig();

class SpeedometerWithNeedle extends Speedometer {
  final double maxSpeed;
  final double initialValue;
  final SpeedometerConfig? config;

  const SpeedometerWithNeedle({
    super.key,
    required this.maxSpeed,
    required this.initialValue,
    required this.config,
  }) : assert(initialValue <= maxSpeed, "Initial value cannot be greater than max value.");

  @override
  // ignore: library_private_types_in_public_api
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<SpeedometerWithNeedle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation<double> curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _animation = Tween<double>(begin: 0, end: widget.initialValue).animate(curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => CustomPaint(
        isComplex: true,
        willChange: true,
        size: widget.config?.size ?? defaultSpeedometerWithNeedleConfig.size,
        painter: SpeedometerWithNeedlePainter(
          animation: _animation,
          maxSpeed: widget.maxSpeed,
          initialValue: widget.initialValue,
          config: widget.config ?? defaultSpeedometerWithNeedleConfig,
        ),
      ),
    );
  }
}


/// TICKS AND VALUES PAINTS

 // Draw the tick marks and labels
    // final tickPaint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2
    //   ..color = Colors.black;

    // const labelStyle = TextStyle(
    //   color: Colors.black,
    //   fontSize: 12,
    // );

    // const tickCount = 20;
    // const tickSpacing = sweepAngle / tickCount;
    // final labelSpacing = maxSpeed / tickCount;

    // for (int i = 0; i <= tickCount; i++) {
    //   final tickAngle = startAngle + i * tickSpacing;
    //   const tickLength = 10;
    //   final tickStart = center + Offset(cos(tickAngle), sin(tickAngle)) * (radius - tickLength);
    //   final tickEnd = center + Offset(cos(tickAngle), sin(tickAngle)) * (radius - 5);

    //   canvas.drawLine(tickStart, tickEnd, tickPaint);

    //   // if (i % 2 == 0) {
    //   final label = '${(i * labelSpacing).round()}';
    //   final labelOffset = Offset(cos(tickAngle), sin(tickAngle)) * (radius - 20);

    //   if (i % 2 == 0) {
    //     final textPainter = TextPainter(
    //       text: TextSpan(
    //         text: label,
    //         style: labelStyle,
    //       ),
    //       textDirection: TextDirection.ltr,
    //     )..layout();
    //     Offset offset = Offset.zero;
    //     final half = (tickCount / 2).round();

    //     if (i == 0) {
    //       offset = const Offset(0, 0);
    //     } else if (i == tickCount) {
    //       offset = const Offset(5, 0);
    //     } else if (i < half) {
    //       offset = const Offset(-5, -5);
    //     } else if (i > half) {
    //       offset = const Offset(5, -5);
    //     } else if (i == half) {
    //       offset = const Offset(0, -5);
    //     }

    //     textPainter.paint(canvas, center + labelOffset - textPainter.size.center(offset));
    //   }
    // }




    /// POINTY NEEDLE:
    /// 
    // final offset = Offset(size.width / 2, size.height / 2);
    // final length = size.width / 2;

    // final path = Path();
    // path.moveTo(offset.dx, offset.dy);
    // path.lineTo(offset.dx - 5, offset.dy + length);
    // path.lineTo(offset.dx + 5, offset.dy + length);
    // path.lineTo(offset.dx, offset.dy);
    // path.close();
    // canvas.drawPath(path, needlePaint);

    // final needlePaint = Paint()
    // ..color = Colors.red
    // ..style = PaintingStyle.fill;

    // final needlePath = Path()
    //   ..moveTo(size.width / 2, 0)
    //   ..lineTo(size.width, size.height)
    //   ..lineTo(0, size.height)
    //   ..lineTo(size.width / 2, 0);