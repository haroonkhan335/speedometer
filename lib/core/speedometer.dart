import 'package:flutter/material.dart';
import 'package:speedometer/config/config.dart';
import 'package:speedometer/speedometers/speedometer_with_needle/speedometer_with_needle.dart';

abstract class Speedometer extends StatefulWidget {
  const Speedometer({
    super.key,
  });

  factory Speedometer.withNeedle({
    required final SpeedometerConfig config,
    required final double initialValue,
    required final double maxSpeed,
  }) =>
      SpeedometerWithNeedle(config: config, initialValue: initialValue, maxSpeed: maxSpeed);
}
