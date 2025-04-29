import 'package:flutter/material.dart';
import 'package:mpos/core/models/responsive_config.dart';

TextStyle textStyle({
  required double fontSize,
  required ResponsiveConfig config,
  FontWeight? fontWeight,
  Color? color,
}) {
  return TextStyle(
    fontSize: fontSize * config.fontSizeMultiplier,
    fontWeight: fontWeight,
    color: color,
  );
  }