import 'package:flutter/material.dart';

import '../constants/constants.dart';

abstract class SpeedometerConfig {
  /// [colorType] transcribes the color of the progress dial of the speedometer. When choosing [SpeedometerColorType.solid], you must also provide the [color] property.
  final SpeedometerColorType colorType;

  /// [colors] paints the color of the progress of the dial in speedometer. [colors] is only used when the [colorType] is set to [SpeedometerColorType.gradient]. By default, [colorType] is [SpeedometerColorType.gradient].
  final List<Color> colors;

  /// [color] defines the color of the progress of the dial in speedometer when [colorType] is set to [SpeedometerColorType.solid]. [color] is mandatory in case of [SpeedometerColorType.solid]
  final Color? color;

  /// The size of the Speedometer widget
  final Size size;

  /// The [duration] of the needle and progress dial animation
  final Duration duration;

  /// [Curve] of the needle and progress animation.
  final Curve curve;

  /// [width] is the thickness of the dial.
  final double width;

  const SpeedometerConfig({
    this.colorType = SpeedometerColorType.gradient,
    this.colors = kProgressDialDefaultGradient,
    this.color,
    this.width = 25,
    this.size = const Size(200, 200),
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.linear,
  }) : assert(
          colorType != SpeedometerColorType.solid || color != null,
          "You must provide a solid color to the speedometer progress dial when choosing to use solid color for Speedometer progress",
        );
}
