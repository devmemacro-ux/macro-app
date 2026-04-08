import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

class ClipGridItem extends StatelessWidget {
  final VideoClip clip;
  final int index;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const ClipGridItem({
    super.key,
    required this.clip,
    required this.index,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            // Thumbnail placeholder
            Container(
              color: AppColors.surfaceElevated,
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
            ),
            // Index badge
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Duration badge
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _formatDuration(clip.duration),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
