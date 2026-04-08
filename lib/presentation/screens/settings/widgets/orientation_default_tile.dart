import 'package:flutter/material.dart';
import 'package:macro_app/core/utils/video_orientation.dart';
import 'package:macro_app/core/theme/app_colors.dart';

class OrientationDefaultTile extends StatelessWidget {
  final VideoOrientation currentOrientation;
  final ValueChanged<VideoOrientation> onChanged;

  const OrientationDefaultTile({
    super.key,
    required this.currentOrientation,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.screen_rotation_outlined),
      title: const Text('Default Orientation'),
      subtitle: Text(_orientationLabel(currentOrientation)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showDialog(context),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Default Orientation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: VideoOrientation.values.map((orient) {
              return RadioListTile<VideoOrientation>(
                title: Text(_orientationLabel(orient)),
                value: orient,
                groupValue: currentOrientation,
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

  String _orientationLabel(VideoOrientation orient) {
    switch (orient) {
      case VideoOrientation.portrait:
        return 'Portrait (9:16)';
      case VideoOrientation.landscape:
        return 'Landscape (16:9)';
      case VideoOrientation.original:
        return 'Original';
    }
  }
}
