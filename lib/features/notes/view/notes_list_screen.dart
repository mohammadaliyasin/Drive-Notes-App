import 'package:drive_notes_app/core/constant/app_size.dart';
import 'package:drive_notes_app/features/notes/controller/notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/date_formatter.dart';

class NoteListScreen extends ConsumerWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('DriveNotes')),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: notes.length,
              padding: const EdgeInsets.all(AppSizes.padding),
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(DateFormatter.format(note.createdAt)),
                    onTap: () {
                      // Navigate to detail or edit screen
                    },
                    onLongPress: () {
                      ref.read(noteControllerProvider.notifier).deleteNote(note.id);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add note screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
