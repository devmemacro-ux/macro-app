import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:macro_app/core/constants/route_constants.dart';
import 'package:macro_app/presentation/screens/home/home_screen.dart';
import 'package:macro_app/presentation/screens/create_project/create_project_screen.dart';
import 'package:macro_app/presentation/screens/project_detail/project_detail_screen.dart';
import 'package:macro_app/presentation/screens/camera/camera_screen.dart';
import 'package:macro_app/presentation/screens/video_production/video_production_screen.dart';
import 'package:macro_app/presentation/screens/about/about_screen.dart';
import 'package:macro_app/presentation/screens/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.createProject,
        name: RouteNames.createProject,
        builder: (context, state) => const CreateProjectScreen(),
      ),
      GoRoute(
        path: RoutePaths.projectDetail,
        name: RouteNames.projectDetail,
        builder: (context, state) {
          final projectId = state.pathParameters['id']!;
          return ProjectDetailScreen(projectId: projectId);
        },
        routes: [
          GoRoute(
            path: RoutePaths.camera,
            name: RouteNames.camera,
            builder: (context, state) {
              final projectId = state.pathParameters['id']!;
              return CameraScreen(projectId: projectId);
            },
          ),
          GoRoute(
            path: RoutePaths.videoProduction,
            name: RouteNames.videoProduction,
            builder: (context, state) {
              final projectId = state.pathParameters['id']!;
              return VideoProductionScreen(projectId: projectId);
            },
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.about,
        name: RouteNames.about,
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
});
