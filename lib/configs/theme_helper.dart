import 'package:flutter/material.dart';

final class ThemeHelper {
  static const Color kPrimaryColor = Color(0xFF6F35A5);
  static const Color kPrimaryLightColor = Color(0xFFF1E6FF);
  static const Color kTransparenteColor = Colors.transparent;

  static ThemeData get theme {
    return ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          shape: const StadiumBorder(),
          maximumSize: const Size(double.infinity, 56),
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: kPrimaryLightColor,
        iconColor: kPrimaryColor,
        prefixIconColor: kPrimaryColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
