import 'package:flutter/material.dart';
import 'package:speedometer/config/config.dart';

import '../../constants/constants.dart';

class SpeedometerWithNeedleConfig extends SpeedometerConfig {
  /// The color of the needle in Speedometer
  final Color needleColor;

  /// The color of the notch at the tip of the Speedometer dial.
  final Color notchColor;

  /// [TextStyle] of the progress digits of Speedometer.
  final TextStyle progressTextStyle;

  /// [TextStyle] of the max value digits of Speedometer.
  final TextStyle maxValueTextStyle;

  const SpeedometerWithNeedleConfig({
    this.needleColor = kNeedleDefaultColor,
    this.notchColor = kNeedleNotchDefaultColor,
    this.progressTextStyle = kDefaultProgressTextStyle,
    this.maxValueTextStyle = kDefaultProgressTextStyle,
    super.colorType = SpeedometerColorType.gradient,
    super.colors = kProgressDialDefaultGradient,
    super.color,
    super.width = 25,
    super.size = const Size(200, 200),
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.linear,
  }) : assert(
          colorType != SpeedometerColorType.solid || color != null,
          "You must provide a solid color to the speedometer progress dial when choosing to use solid color for Speedometer progress",
        );
}
