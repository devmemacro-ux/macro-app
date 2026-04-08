import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';

class ExportProgressBarWidget extends StatelessWidget {
  final double progress;
  final String statusText;

  const ExportProgressBarWidget({
    super.key,
    required this.progress,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.surfaceElevated,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 8,
        ),
        const SizedBox(height: 8),
        Text(
          '$statusText — ${(progress * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
