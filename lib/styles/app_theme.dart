import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Clr.black),
    scaffoldBackgroundColor: Clr.white,
    useMaterial3: true,
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      color: Clr.white,
    ),
  );
}
