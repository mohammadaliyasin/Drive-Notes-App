import 'package:drive_notes_app/data/models/notes_model.dart';
import 'package:drive_notes_app/data/providers/notes_repositories_provider.dart';
import 'package:drive_notes_app/data/repositories/note_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteControllerProvider = 
    StateNotifierProvider<NoteController, List<NoteModel>>((ref) {
  final repository = ref.watch(noteRepositoryProvider);
  return NoteController(repository)..loadNotes();
});

class NoteController extends StateNotifier<List<NoteModel>> {
  final NoteRepository repository;

  NoteController(this.repository) : super([]);

  void loadNotes() {
    final notes = repository.getAllNotes();
    state = notes;
  }

  Future<void> addNote(NoteModel note) async {
    await repository.addNote(note, syncWithDrive: true);
    loadNotes();
  }

  Future<void> updateNote(NoteModel note) async {
    await repository.updateNote(note, syncWithDrive: true);
    loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await repository.deleteNote(id);
    loadNotes();
  }
}