import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class IOSTheme {
  static CupertinoThemeData get cupertinoTheme {
    return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      primaryContrastingColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.background,
      barBackgroundColor: CupertinoColors.systemBackground,
      textTheme: CupertinoTextThemeData(
        primaryColor: AppColors.primary,
        textStyle: TextStyle(
          fontFamily: '.SF Pro Text',
          fontSize: 17,
          color: AppColors.textPrimary,
          letterSpacing: -0.41,
        ),
      ),
    );
  }

  static ThemeData get materialThemeForIOS {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: CupertinoColors.systemBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: '.SF Pro Display',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
          letterSpacing: -0.41,
        ),
      ),
      // iOS-style buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: '.SF Pro Text',
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // iOS-style inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CupertinoColors.systemGrey6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(
          fontFamily: '.SF Pro Text',
          color: CupertinoColors.inactiveGray,
          fontSize: 17,
        ),
      ),
      // iOS-style cards
      cardTheme: CardThemeData(
        color: CupertinoColors.systemBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      // iOS-style bottom nav
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: CupertinoColors.systemBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: CupertinoColors.inactiveGray,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      // iOS-style lists
      dividerTheme: const DividerThemeData(
        color: CupertinoColors.separator,
        thickness: 0.5,
        space: 0.5,
      ),
    );
  }
}
