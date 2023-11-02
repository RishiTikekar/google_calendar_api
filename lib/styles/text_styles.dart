import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testtask/styles/styles.dart';

class TStyle {
  static TextStyle baseStyle = GoogleFonts.lato(
    color: Clr.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle T_14_400 = baseStyle;

  static TextStyle T_16_400 = baseStyle.copyWith(fontSize: 16);

  static TextStyle T_18_500 = baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
