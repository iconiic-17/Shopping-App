import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';
import 'package:shopping_app/core/theme/app_text_styles.dart';

abstract class AppTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundGrey,
    dividerColor: AppColors.border,
    hintColor: AppColors.textHint,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.orangeLight,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: AppColors.white,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.backGroundGrey,
      centerTitle: true,
      foregroundColor: AppColors.black,
      titleTextStyle: AppTextStyles.font22SemiBold,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.border,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: AppFontWeight.bold,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fieldFill,
      prefixIconColor: AppColors.textSecondary,
      suffixIconColor: AppColors.textSecondary,
      hintStyle: AppTextStyles.font14Regular,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.font32Bold,
      headlineMedium: AppTextStyles.font28Bold,
      headlineSmall: AppTextStyles.font24Bold,
      titleLarge: AppTextStyles.font22Bold,
      titleMedium: AppTextStyles.font16SemiBold,
      titleSmall: AppTextStyles.font14SemiBold,
      bodyLarge: AppTextStyles.font18Medium,
      bodyMedium: AppTextStyles.font16Regular,
      bodySmall: AppTextStyles.font12Regular,
      labelLarge: TextStyle(
        fontSize: 16,
        color: AppColors.white,
        fontWeight: AppFontWeight.bold,
      ),
      labelMedium: AppTextStyles.font14Medium,
      labelSmall: AppTextStyles.font11Medium,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 40,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.backGroundGrey,
      selectedItemColor: AppColors.orangeLight,
      unselectedItemColor: AppColors.greyDark,
      selectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: AppFontWeight.medium,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: AppFontWeight.medium,
      ),
      selectedIconTheme: IconThemeData(size: 24),
    ),
  );
}
