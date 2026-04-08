import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/domain/entities/export_settings.dart';
import 'package:macro_app/presentation/providers/camera_providers.dart';
import 'package:macro_app/presentation/providers/export_providers.dart';

class VideoProductionScreen extends ConsumerWidget {
  final String projectId;
  const VideoProductionScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clipsAsync = ref.watch(projectClipsProvider(projectId));
    final exportState = ref.watch(exportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produce Video'),
      ),
      body: clipsAsync.when(
        data: (clips) {
          if (clips.isEmpty) {
            return const Center(
              child: Text('No clips to produce. Record some clips first.'),
            );
          }
          return Column(
            children: [
              // Clip list
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: clips.length,
                  onReorder: (oldIndex, newIndex) {
                    // TODO: Reorder clips
                  },
                  itemBuilder: (context, index) {
                    final clip = clips[index];
                    return _ClipTile(
                      key: ValueKey(clip.id),
                      clip: clip,
                      index: index,
                    );
                  },
                ),
              ),
              // Export config & button
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (exportState.status == ExportStatus.exporting) ...[
                      LinearProgressIndicator(value: exportState.progress),
                      const SizedBox(height: 8),
                      Text(
                        'Exporting... ${(exportState.progress * 100).toInt()}%',
                        style: const TextStyle(color: AppColors.textSecondary),
                      ),
                    ] else if (exportState.status == ExportStatus.complete) ...[
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 32,
                      ),
                      const Text(
                        'Export complete!',
                        style: TextStyle(color: AppColors.success),
                      ),
                    ] else if (exportState.status == ExportStatus.error) ...[
                      Text(
                        exportState.error ?? 'Unknown error',
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ],
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: exportState.status == ExportStatus.exporting
                          ? null
                          : () => _startExport(ref, clips),
                      icon: const Icon(Icons.movie_creation),
                      label: const Text('Export Video'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _startExport(WidgetRef ref, List<VideoClip> clips) {
    final notifier = ref.read(exportProvider.notifier);
    final clipIds = clips.map((c) => c.id).toList();
    notifier.startExport(
      projectId: projectId,
      orderedClipIds: clipIds,
      config: const ExportSettings(),
    );
  }
}

class _ClipTile extends StatelessWidget {
  final VideoClip clip;
  final int index;
  const _ClipTile({
    required super.key,
    required this.clip,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 64,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        title: Text('Clip ${index + 1}'),
        subtitle: Text(
          '${clip.duration.inSeconds}s · ${clip.sourceResolution.name}',
        ),
        trailing: const Icon(Icons.drag_handle, color: AppColors.textMuted),
      ),
    );
  }
}
