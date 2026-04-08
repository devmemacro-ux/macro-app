import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/presentation/providers/camera_providers.dart';

class CameraScreen extends ConsumerStatefulWidget {
  final String projectId;
  const CameraScreen({super.key, required this.projectId});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraSessionProvider);
    final cameraNotifier = ref.read(cameraSessionProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // Camera preview
          CameraAwesomeBuilder.custom(
            saveConfig: SaveConfig.photoAndVideo(),
            builder: (state, previewSize, Rect previewRect) {
              return Stack(
                children: [
                  // Top bar controls
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back button
                            IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () => context.pop(),
                            ),
                            // Recording indicator
                            if (_isRecording)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
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
                                      _formatDuration(
                                        cameraState.recordingDuration,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            // Orientation indicator
                            IconButton(
                              icon: const Icon(
                                Icons.screen_rotation_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                // TODO: Toggle output orientation
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Bottom controls
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Flash toggle
                            IconButton(
                              icon: const Icon(
                                Icons.flash_on_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () {
                                // TODO: Toggle flash
                              },
                            ),
                            // Record button
                            GestureDetector(
                              onTapDown: (_) {
                                _isRecording = true;
                                cameraNotifier.startRecording();
                              },
                              onTapUp: (_) async {
                                _isRecording = false;
                                await cameraNotifier.stopRecording(
                                  widget.projectId,
                                );
                              },
                              onTapCancel: () {
                                _isRecording = false;
                                cameraNotifier.stopRecording(widget.projectId);
                              },
                              child: Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  color: _isRecording
                                      ? AppColors.recordingRed
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: _isRecording
                                      ? Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        )
                                      : Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: AppColors.recordingRed,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            // Switch camera
                            IconButton(
                              icon: const Icon(
                                Icons.flip_camera_ios_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () {
                                // TODO: Switch camera
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
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
