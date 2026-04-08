import 'package:flutter/material.dart';
import 'package:macro_app/core/theme/app_colors.dart';

class ProjectNameInput extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final VoidCallback? onSubmitted;

  const ProjectNameInput({
    super.key,
    required this.controller,
    this.errorText,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          maxLength: 100,
          decoration: InputDecoration(
            labelText: 'Project Name',
            hintText: 'Enter a name for your video project',
            prefixIcon: const Icon(Icons.title),
            errorText: errorText,
            filled: true,
            fillColor: AppColors.surfaceElevated,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          onSubmitted: (_) => onSubmitted?.call(),
        ),
      ],
    );
  }
}
