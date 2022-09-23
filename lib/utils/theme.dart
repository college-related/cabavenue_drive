import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color themeColor = Color(0xFF1E1E1E);
  static ThemeData light() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xffF6FBFF),
      brightness: Brightness.light,
      primaryColor: themeColor,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return const Color(0xFF1E1E1E);
          },
        ),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: themeColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF1E1E1E),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
