import 'package:flutter/material.dart';
import 'package:shopping_app/core/theme/app_colors.dart';
import 'package:shopping_app/core/theme/app_font_weight.dart';

abstract class AppTextStyles {
  // Headings
  static const TextStyle font32Bold = TextStyle(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font28Bold = TextStyle(
    fontSize: 28,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font24Bold = TextStyle(
    fontSize: 24,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textPrimary,
  );

  // Titles / AppBars
  static const TextStyle font22Bold = TextStyle(
    fontSize: 22,
    fontWeight: AppFontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font22SemiBold = TextStyle(
    fontSize: 22,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.black,
  );

  static const TextStyle font20SemiBold = TextStyle(
    fontSize: 20,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.textPrimary,
  );

  // Body & Subtitles
  static const TextStyle font18Medium = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.medium,
    color: AppColors.textPrimary,
  );

  static const TextStyle font18ExtraBold = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.extraBold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font16Bold = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle font16SemiBold = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font16Medium = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.medium,
    color: AppColors.textPrimary,
  );

  static const TextStyle font16Regular = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textPrimary,
  );

  // Labels & Smaller text
  static const TextStyle font14SemiBold = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font14Medium = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.medium,
    color: AppColors.textSecondary,
  );

  static const TextStyle font14Regular = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textHint,
  );

  static const TextStyle font13SemiBold = TextStyle(
    fontSize: 13,
    fontWeight: AppFontWeight.semiBold,
    color: AppColors.textPrimary,
  );

  static const TextStyle font12Regular = TextStyle(
    fontSize: 12,
    fontWeight: AppFontWeight.regular,
    color: AppColors.textSecondary,
  );

  static const TextStyle font11Medium = TextStyle(
    fontSize: 11,
    fontWeight: AppFontWeight.medium,
    color: AppColors.textSecondary,
  );
}

extension AppTypographyExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
