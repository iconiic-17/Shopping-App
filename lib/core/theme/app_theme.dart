import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    // Color scaffold
    scaffoldBackgroundColor: AppColors.backGroundGrey,

    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.backGroundGrey,
      centerTitle: true,
      foregroundColor: AppColors.black,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backGroundGrey,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.grey,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.orangeLight, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.grey, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.red, width: 2),
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),

      bodyMedium: TextStyle(
        fontSize: 18,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),

      labelMedium: TextStyle(
        fontSize: 14,
        color: AppColors.black,
        fontWeight: FontWeight.w400,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 40,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.backGroundGrey,
      selectedItemColor: AppColors.orangeLight,
      unselectedItemColor: AppColors.greyDark,

      selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),

      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      selectedIconTheme: IconThemeData(size: 24),
    ),
  );
}
