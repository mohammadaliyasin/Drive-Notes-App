import 'package:drive_notes_app/core/constant/app_string.dart';
import 'package:drive_notes_app/data/models/notes_model.dart';
import 'package:hive/hive.dart';


class HiveService {
  late Box<NoteModel> _noteBox;

  Future<void> init() async {
    _noteBox = await Hive.openBox<NoteModel>(AppStrings.notesBox);
  }

  List<NoteModel> getAllNotes() => _noteBox.values.toList();

  Future<void> addNote(NoteModel note) async => await _noteBox.put(note.id, note);

  Future<void> deleteNote(String id) async => await _noteBox.delete(id);

  Future<void> updateNote(NoteModel note) async => await _noteBox.put(note.id, note);

  NoteModel? getNoteById(String id) => _noteBox.get(id);
}
