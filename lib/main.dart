import 'package:drive_notes_app/core/constant/app_string.dart';
import 'package:drive_notes_app/core/theme/app_theme.dart' show AppTheme;
import 'package:drive_notes_app/data/datasources/local_storage_datasources.dart';
import 'package:drive_notes_app/data/models/notes_model.dart';
import 'package:drive_notes_app/routes/app_routes.dart' show appRouter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(AppStrings.notesBox);

  final hiveService = HiveService();
  await hiveService.init();

  runApp(
    const ProviderScope(child: DriveNotesApp()),
  );
}

class DriveNotesApp extends StatelessWidget {
  const DriveNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
