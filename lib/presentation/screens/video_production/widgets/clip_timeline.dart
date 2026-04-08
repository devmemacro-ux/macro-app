import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

class ClipTimeline extends StatelessWidget {
  final List<VideoClip> clips;
  final Function(int oldIndex, int newIndex) onReorder;

  const ClipTimeline({
    super.key,
    required this.clips,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: clips.length,
      onReorder: onReorder,
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final double t = Curves.easeInOut.transform(animation.value);
            final double scale = 1.0 + (0.05 * t);
            return Transform.scale(
              scale: scale,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: child,
              ),
            );
          },
          child: child,
        );
      },
      itemBuilder: (context, index) {
        final clip = clips[index];
        return _TimelineClip(
          key: ValueKey(clip.id),
          clip: clip,
          index: index,
        );
      },
    );
  }
}

class _TimelineClip extends StatelessWidget {
  final VideoClip clip;
  final int index;
  const _TimelineClip({
    required super.key,
    required this.clip,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: const Center(
                child: Icon(Icons.play_arrow, color: AppColors.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              children: [
                Text(
                  'Clip ${index + 1}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${clip.duration.inSeconds}s',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
