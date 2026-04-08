import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:macro_app/app.dart';
import 'package:macro_app/core/di/injection.dart';
import 'package:macro_app/data/datasources/local/clip_database.dart';
import 'package:macro_app/data/datasources/local/project_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request camera and microphone permissions
  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.storage.request();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D0D1A),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Force portrait orientation for non-camera screens
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Isar database
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [ProjectSchemaSchema, ClipSchemaSchema],
    directory: dir.path,
  );

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(isar),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MacroApp(),
    ),
  );
}
