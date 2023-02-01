import 'package:flutter/material.dart';
import 'package:speedometer/config/config.dart';

import '../../constants/constants.dart';

class DonutSpeedometerConfig extends SpeedometerConfig {
  /// The color of the needle in Speedometer
  final Color needleColor;

  /// The color of the notch at the tip of the Speedometer dial.
  final Color notchColor;

  /// [TextStyle] of the progress digits of Speedometer.
  final TextStyle progressTextStyle;

  /// Unit of the value taking in the Speedometer (for example, %, $, ms, Km)
  final String? unit;

  const DonutSpeedometerConfig({
    this.needleColor = kNeedleDefaultColor,
    this.notchColor = kNeedleNotchDefaultColor,
    this.progressTextStyle = kDefaultProgressTextStyle,
    super.colorType = SpeedometerColorType.solid,
    super.colors,
    super.width = 25,
    super.size = const Size(200, 200),
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.linear,
    this.unit,
    super.color = kDefaultDonutColor,
  }) : assert(
          colorType != SpeedometerColorType.gradient || colors != null,
          "You must provide a solid color to the speedometer progress dial when choosing to use solid color for Speedometer progress",
        );
}
