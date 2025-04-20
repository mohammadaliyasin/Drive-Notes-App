import 'package:drive_notes_app/data/models/notes_model.dart';
import 'package:drive_notes_app/data/providers/notes_repositories_provider.dart';
import 'package:drive_notes_app/data/repositories/note_repository_impl.dart';
import 'package:drive_notes_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'dart:convert';

final driveSyncServiceProvider = Provider<DriveSyncService>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  final authService = ref.watch(authServiceProvider);
  return DriveSyncService(repository: repository, authService: authService);
});

class DriveSyncService {
  final NoteRepository repository;
  final AuthService authService;

  DriveSyncService({required this.repository, required this.authService});

  Future<void> syncNotesFromDrive() async {
    final client = authService.client;
    if (client == null) return;

    final folderId = await repository.driveService.getDriveNotesFolderId();
    if (folderId == null) return;

    final driveFiles = await repository.driveService.listNoteFiles(folderId);

    for (var file in driveFiles) {
      final contentMedia = await repository.driveService.driveApi.files.get(
        file.id!,
        downloadOptions: drive.DownloadOptions.fullMedia,
      );

      final content = await utf8.decodeStream((contentMedia as drive.Media).stream);
      final note = NoteModel(
        id: file.id!,
        title: file.name!.replaceAll('.txt', ''),
        content: content,
        createdAt: file.createdTime ?? DateTime.now(),
      );
      await repository.hiveService.addNote(note);
    }
  }
}