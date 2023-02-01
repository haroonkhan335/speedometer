import 'package:flutter/material.dart';

enum SpeedometerColorType { solid, gradient }

const Color kNeedleDefaultColor = Color.fromARGB(221, 0, 0, 0);
const Color kNeedleNotchDefaultColor = Colors.white;
const List<Color> kProgressDialDefaultGradient = [Color(0xFF5FD6B5), Color(0xFF05A377)];
const TextStyle kDefaultProgressTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 22,
  color: Colors.black,
);
const Color kDefaultDonutColor = Color(0xFFFFD56A);
