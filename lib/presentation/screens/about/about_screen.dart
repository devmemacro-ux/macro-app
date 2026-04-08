import 'package:flutter/material.dart';
import 'package:macro_app/core/constants/app_constants.dart';
import 'package:macro_app/core/theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // App icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_enhance_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              AppConstants.appNameArabic,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Version ${AppConstants.version}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 32),
            const Divider(color: AppColors.surfaceElevated),
            const SizedBox(height: 24),
            // Developer info
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_outline, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  AppConstants.developerName,
                  style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(color: AppColors.surfaceElevated),
            const SizedBox(height: 32),
            // Dedication card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.surfaceElevated,
                    AppColors.card,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.tertiary.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    AppConstants.dedicationArabic,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      height: 1.8,
                      color: AppColors.tertiary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '\u2764\uFE0F',
                    style: TextStyle(fontSize: 36),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Divider(color: AppColors.surfaceElevated),
            const SizedBox(height: 16),
            Text(
              '\u00A9 2026 ${AppConstants.developerName}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
