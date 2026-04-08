import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/presentation/providers/camera_providers.dart';
import 'package:macro_app/presentation/providers/project_providers.dart';
import 'package:shimmer/shimmer.dart';

class ProjectDetailScreen extends ConsumerWidget {
  final String projectId;
  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clipsAsync = ref.watch(projectClipsProvider(projectId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Clips'),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/project/$projectId/produce'),
            icon: const Icon(Icons.movie_creation_outlined, size: 18),
            label: const Text('Produce'),
          ),
        ],
      ),
      body: clipsAsync.when(
        data: (clips) {
          if (clips.isEmpty) {
            return _EmptyClipsState(projectId: projectId);
          }
          return _ClipsList(clips: clips);
        },
        loading: () => const _LoadingShimmer(),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/project/$projectId/camera'),
        icon: const Icon(Icons.videocam),
        label: const Text('Camera'),
      ),
    );
  }
}

class _EmptyClipsState extends StatelessWidget {
  final String projectId;
  const _EmptyClipsState({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.videocam_off_outlined,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No clips yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the Camera button to start recording',
            style: TextStyle(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ClipsList extends StatelessWidget {
  final List<VideoClip> clips;
  const _ClipsList({required this.clips});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: clips.length,
      itemBuilder: (context, index) {
        final clip = clips[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.play_arrow, color: AppColors.primary),
            ),
            title: Text('Clip ${index + 1}'),
            subtitle: Text(
              '${clip.duration.inSeconds}s · ${clip.sourceResolution.name}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                // TODO: Delete clip
              },
            ),
          ),
        );
      },
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.surfaceElevated,
          highlightColor: AppColors.card,
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 48,
                height: 48,
                color: Colors.white,
              ),
              title: Container(width: 120, height: 14, color: Colors.white),
              subtitle: Container(width: 80, height: 10, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
