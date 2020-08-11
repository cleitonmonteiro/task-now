import 'package:flutter/material.dart';

const kButtonTheme = ButtonThemeData(
  textTheme: ButtonTextTheme.primary,
  padding: EdgeInsets.symmetric(horizontal: 10.0),
  minWidth: 30.0,
  height: 30.0,
);

class AppTheme {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.purple,
      backgroundColor: Colors.white,
      buttonTheme: kButtonTheme,
    );
  }

  static ThemeData getDarkTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.purple,
        secondary: Colors.purple,
        secondaryVariant: Colors.purple,
        surface: Colors.grey.shade900,
      ),
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.purple,
      accentColor: Colors.purple,
      toggleableActiveColor: Colors.purple,
      scaffoldBackgroundColor: Colors.grey.shade900,
      backgroundColor: Colors.grey.shade900,
      dialogBackgroundColor: Colors.grey.shade900,
      selectedRowColor: Colors.grey.withAlpha(20),
      timePickerTheme: TimePickerTheme.of(context).copyWith(
        hourMinuteUnselectedColor: Colors.red,
        dialBackgroundColor: Colors.grey.withAlpha(20),
      ),
      buttonTheme: kButtonTheme,
    );
  }
}
