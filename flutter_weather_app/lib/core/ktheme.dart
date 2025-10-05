import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Ktheme {
  static final appTheme = ThemeData.dark().copyWith(
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Colors.white, iconSize: 24),
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white54,
      ),
      titleLarge: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.white,
        fontSize: 64,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
    ),
    dialogBackgroundColor: const Color(0xFF121212),
  );
}
