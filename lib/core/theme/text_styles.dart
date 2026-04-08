import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String defaultFontFamily = 'Roboto';

  static TextTheme get theme => const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary,
        ),
      );
}
