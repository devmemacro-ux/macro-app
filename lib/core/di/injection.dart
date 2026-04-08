import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Database
final databaseProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'Database not initialized. Call initializeDatabase() first.',
  );
});

// Settings
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized.');
});

// Initialize Isar database
Future<Isar> initializeDatabase() async {
  // Note: Isar requires native libs — this will be fully set up when
  // the project is built with flutter pub get + build_runner.
  // For now, return a placeholder. The actual initialization happens in main.dart.
  throw UnimplementedError(
    'Initialize database in main.dart after flutter pub get.\n'
    'Run: dart run build_runner build --delete-conflicting-outputs\n'
    'Then: Isar.open([schemas...])',
  );
}
