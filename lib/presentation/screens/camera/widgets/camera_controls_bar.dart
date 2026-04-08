import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';

enum FlashMode { off, on, auto, torch }

class CameraControlsBar extends StatelessWidget {
  final FlashMode flashMode;
  final VoidCallback onFlashToggle;
  final VoidCallback onSwitchCamera;
  final VoidCallback onBack;
  final bool isRecording;
  final Duration recordingDuration;

  const CameraControlsBar({
    super.key,
    required this.flashMode,
    required this.onFlashToggle,
    required this.onSwitchCamera,
    required this.onBack,
    this.isRecording = false,
    this.recordingDuration = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 28,
              ),
              onPressed: onBack,
            ),
            if (isRecording)
              _RecordingIndicator(duration: recordingDuration),
            IconButton(
              icon: Icon(
                _flashIcon,
                color: flashMode == FlashMode.on
                    ? AppColors.primary
                    : Colors.white,
                size: 24,
              ),
              onPressed: onFlashToggle,
            ),
          ],
        ),
      ),
    );
  }

  IconData get _flashIcon {
    switch (flashMode) {
      case FlashMode.off:
        return Icons.flash_off_outlined;
      case FlashMode.on:
        return Icons.flash_on_outlined;
      case FlashMode.auto:
        return Icons.flash_auto_outlined;
      case FlashMode.torch:
        return Icons.flashlight_on_outlined;
    }
  }
}

class _RecordingIndicator extends StatelessWidget {
  final Duration duration;
  const _RecordingIndicator({required this.duration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.recordingRed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            _formatDuration(duration),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
