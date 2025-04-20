

import 'package:drive_notes_app/data/datasources/google_drive_datasources.dart';
import 'package:drive_notes_app/data/datasources/local_storage_datasources.dart';
import 'package:drive_notes_app/data/models/notes_model.dart';

class NoteRepository {
  final HiveService hiveService;
  final DriveApiService driveService;

  NoteRepository({required this.hiveService, required this.driveService});

  List<NoteModel> getAllNotes() => hiveService.getAllNotes();

  Future<void> addNote(NoteModel note, {bool syncWithDrive = false}) async {
    await hiveService.addNote(note);
    if (syncWithDrive) {
      final folderId = await driveService.getDriveNotesFolderId() ?? await driveService.createDriveNotesFolder();
      await driveService.createNoteFile(folderId, note.title, note.content);
    }
  }

  Future<void> deleteNote(String id) async => await hiveService.deleteNote(id);

  Future<void> updateNote(NoteModel note, {bool syncWithDrive = false}) async {
    await hiveService.updateNote(note);
    if (syncWithDrive) {
      // Implement logic to sync with Drive if needed
    }
  }

  NoteModel? getNoteById(String id) => hiveService.getNoteById(id);
}
