import 'package:drive_notes_app/core/utils/validator.dart';
import 'package:drive_notes_app/data/models/notes_model.dart';
import 'package:drive_notes_app/features/notes/controller/notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';


class NoteFormScreen extends ConsumerStatefulWidget {
  final NoteModel? existingNote;

  const NoteFormScreen({super.key, this.existingNote});

  @override
  ConsumerState<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends ConsumerState<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingNote?.title ?? '');
    _contentController = TextEditingController(text: widget.existingNote?.content ?? '');
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final isNew = widget.existingNote == null;
      final note = NoteModel(
        id: isNew ? const Uuid().v4() : widget.existingNote!.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        createdAt: isNew ? DateTime.now() : widget.existingNote!.createdAt,
      );
      isNew
          ? ref.read(noteControllerProvider.notifier).addNote(note)
          : ref.read(noteControllerProvider.notifier).updateNote(note);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.existingNote == null ? 'Add Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: Validators.validateNoteTitle,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 6,
                validator: Validators.validateNoteContent,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text(widget.existingNote == null ? 'Save Note' : 'Update Note'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
