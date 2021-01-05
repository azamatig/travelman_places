import 'dart:ui';

import 'package:flutter/material.dart';

mixin AppTheme {
  //MAIN COLORS
  static const primaryGreenColor = Color(0xff2196f3);
  static const primaryDarkColor = Color(0xff013245);
  static const yellowColor = Color(0xffffe102);
  static const blueColor = Color(0xff00ebff);
  static const pinkColor = Color(0xffffb8e7);

  static final lightTheme = ThemeData().copyWith(
    primaryColor: primaryGreenColor,
    secondaryHeaderColor: yellowColor,
    accentColor: blueColor,
    primaryColorLight: pinkColor,
    primaryColorDark: primaryDarkColor,
  );
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryDarkColor,
    secondaryHeaderColor: yellowColor,
    accentColor: blueColor,
    primaryColorLight: pinkColor,
    primaryColorDark: primaryGreenColor,
  );

  static final primaryGradient = LinearGradient(
    colors: [primaryGreenColor, blueColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
