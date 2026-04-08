import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macro_app/core/constants/route_constants.dart';
import 'package:macro_app/core/theme/app_colors.dart';
import 'package:macro_app/presentation/providers/project_providers.dart';

class CreateProjectScreen extends ConsumerStatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  ConsumerState<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends ConsumerConsumerState<CreateProjectScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _createProject() async {
    final formNotifier = ref.read(createProjectFormProvider.notifier);
    formNotifier.setName(_nameController.text);
    formNotifier.setDescription(_descController.text);

    final success = await formNotifier.submit();
    if (success && mounted) {
      context.go(RoutePaths.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(createProjectFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Project'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.video_library_rounded,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: 'Project Name',
                hintText: 'Enter a name for your video project',
                prefixIcon: Icon(Icons.title),
              ),
              autofocus: true,
              onSubmitted: (_) => _createProject(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 3,
              maxLength: 500,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Describe your project...',
                prefixIcon: Icon(Icons.description_outlined),
                alignLabelWithHint: true,
              ),
            ),
            if (formState.error != null) ...[
              const SizedBox(height: 16),
              Text(
                formState.error!,
                style: const TextStyle(color: AppColors.error),
              ),
            ],
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: formState.isLoading ? null : _createProject,
              child: formState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create Project'),
            ),
          ],
        ),
      ),
    );
  }
}
