import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';

class ProjectStatsHeader extends StatelessWidget {
  final String projectName;
  final int clipCount;
  final Duration totalDuration;
  final DateTime lastUpdated;

  const ProjectStatsHeader({
    super.key,
    required this.projectName,
    required this.clipCount,
    required this.totalDuration,
    required this.lastUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            projectName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StatChip(
                icon: Icons.movie_outlined,
                label: '$clipCount clips',
              ),
              const SizedBox(width: 8),
              _StatChip(
                icon: Icons.timer_outlined,
                label: _formatTotalDuration(totalDuration),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTotalDuration(Duration d) {
    final totalSeconds = d.inSeconds;
    if (totalSeconds < 60) return '${totalSeconds}s';
    final minutes = d.inMinutes;
    final seconds = totalSeconds % 60;
    return '${minutes}m ${seconds}s';
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
