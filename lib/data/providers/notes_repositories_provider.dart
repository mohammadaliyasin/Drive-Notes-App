import 'package:drive_notes_app/data/datasources/google_drive_datasources.dart';
import 'package:drive_notes_app/data/datasources/local_storage_datasources.dart';
import 'package:drive_notes_app/data/repositories/note_repository_impl.dart';
import 'package:drive_notes_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final hiveService = HiveService();
  final authService = ref.watch(authServiceProvider);
  final driveClient = authService.client;

  if (driveClient == null) {
    throw Exception('Drive client is not initialized');
  }

  final driveService = DriveApiService(client: driveClient);

  return NoteRepository(
    hiveService: hiveService,
    driveService: driveService,
  );
});
