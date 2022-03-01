import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkColors {
  static const HOMEPAGE_COLOR = Color(0xFF2d2f41);
  static const CLOCK_COLOR = Color(0xFF444974);
  static const CLOCK_OUTLINECOLOR = Color(0xFFEAECFF);
  static const SEC_COLOR = Color(0xFFFFB74D);
  static const DASHBRUSH_COLOR = Color(0xFF808080);
  static const MIN_GRADIANT =
      RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)]);
  static const HOUR_GRADIANT =
      RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)]);
}

class LightColors {
  static const HOMEPAGE_COLOR = Color(0xffffd587);
  static const CLOCK_COLOR = Color(0xFFffffff);
  static const CLOCK_OUTLINECOLOR = Colors.blueAccent;
  static const SEC_COLOR = Colors.orange;
  static const DASHBRUSH_COLOR = Colors.redAccent;
  static const MIN_GRADIANT =
      RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)]);
  static const HOUR_GRADIANT =
      RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)]);
}
