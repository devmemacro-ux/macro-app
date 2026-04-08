import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/domain/entities/video_clip.dart';
import 'package:macro_app/presentation/providers/export_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Camera'),
          // Default resolution
          ListTile(
            leading: const Icon(Icons.hd_outlined),
            title: const Text('Default Resolution'),
            subtitle: Text(settings.defaultResolution.name.toUpperCase()),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showResolutionDialog(context, ref),
          ),
          // Enable audio
          SwitchListTile(
            secondary: const Icon(Icons.mic_outlined),
            title: const Text('Record Audio by Default'),
            value: settings.enableAudioByDefault,
            onChanged: (value) {
              ref.read(settingsProvider.notifier).setEnableAudio(value);
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'Export'),
          // Default export quality
          ListTile(
            leading: const Icon(Icons.tune_outlined),
            title: const Text('Export Quality'),
            subtitle: const Text('High (CRF 18)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show export quality dialog
            },
          ),
          const Divider(),
          const _SectionHeader(title: 'Storage'),
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('App Storage'),
            subtitle: const Text('Tap to manage'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Show storage info
            },
          ),
        ],
      ),
    );
  }

  void _showResolutionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Default Resolution'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: VideoResolution.values.map((res) {
              return RadioListTile<VideoResolution>(
                title: Text(res.name.toUpperCase()),
                value: res,
                groupValue: ref.read(settingsProvider).defaultResolution,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(settingsProvider.notifier).setDefaultResolution(value);
                    Navigator.of(context).pop();
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
