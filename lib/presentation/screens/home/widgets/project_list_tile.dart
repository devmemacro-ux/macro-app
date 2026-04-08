import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/domain/entities/video_project.dart';

class ProjectListTile extends StatelessWidget {
  final VideoProject project;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const ProjectListTile({
    super.key,
    required this.project,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: project.coverImagePath.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(project.coverImagePath, fit: BoxFit.cover),
              )
            : Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.movie_outlined,
                  color: AppColors.primary,
                ),
              ),
        title: Text(
          project.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${project.clipCount} clips · ${DateFormat('MMM d, yyyy').format(project.updatedAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                ),
                onPressed: onDelete,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
