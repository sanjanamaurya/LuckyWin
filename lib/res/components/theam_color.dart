import 'package:flutter/material.dart';

ThemeData myCustomTheme = ThemeData.dark().copyWith(
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white), // --van-picker-option-text-color
  ),
  scaffoldBackgroundColor: const Color(0xFF22275B), // --van-picker-background
  dialogBackgroundColor: const Color(0xFF22275B),
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(color: Colors.white), // --van-dialog-has-title-message-text-color
  ), colorScheme: const ColorScheme.dark(
    primary: Color(0xFF375192), // --van-border-color
    onPrimary: Colors.white, // --van-text-color
  ).copyWith(background: const Color(0xFF22275B)),
);

extension MyCustomTheme on ThemeData {
  Color get vanBorderColor => primaryColor.withOpacity(0.5); // --van-border-color
  LinearGradient get vanPickerMaskColor => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF22275B).withOpacity(0.9), // linear gradient 1 color start
      const Color(0xFF22275B).withOpacity(0.4), // linear gradient 1 color end
      const Color(0xFF22275B).withOpacity(0.9), // linear gradient 2 color start
      const Color(0xFF22275B).withOpacity(0.4), // linear gradient 2 color end
    ],
  ); // --van-picker-mask-color
}
