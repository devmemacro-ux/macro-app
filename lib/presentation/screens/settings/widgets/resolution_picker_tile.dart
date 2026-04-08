import 'package:flutter/material.dart';
import 'package:macro_app/domain/entities/video_clip.dart';

class ResolutionPickerTile extends StatelessWidget {
  final VideoResolution currentResolution;
  final ValueChanged<VideoResolution> onChanged;

  const ResolutionPickerTile({
    super.key,
    required this.currentResolution,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.hd_outlined),
      title: const Text('Default Resolution'),
      subtitle: Text(currentResolution.name.toUpperCase()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Resolution'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: VideoResolution.values.map((res) {
              return RadioListTile<VideoResolution>(
                title: Text(_resolutionLabel(res)),
                subtitle: Text(_resolutionSize(res)),
                value: res,
                groupValue: currentResolution,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
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

  String _resolutionLabel(VideoResolution res) {
    switch (res) {
      case VideoResolution.hd720:
        return 'HD 720p';
      case VideoResolution.hd1080:
        return 'Full HD 1080p';
      case VideoResolution.qhd1440:
        return 'QHD 1440p';
      case VideoResolution.uhd4k:
        return '4K UHD';
    }
  }

  String _resolutionSize(VideoResolution res) {
    switch (res) {
      case VideoResolution.hd720:
        return '1280x720';
      case VideoResolution.hd1080:
        return '1920x1080';
      case VideoResolution.qhd1440:
        return '2560x1440';
      case VideoResolution.uhd4k:
        return '3840x2160';
    }
  }
}
