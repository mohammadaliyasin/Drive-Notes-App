import 'package:drive_notes_app/data/models/notes_model.dart';
import 'package:drive_notes_app/features/auth/view/auth_screen.dart';
import 'package:drive_notes_app/features/notes/view/notes_form_screen.dart';
import 'package:drive_notes_app/features/notes/view/notes_list_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/notes',
      name: 'notes',
      builder: (context, state) => const NoteListScreen(),
    ),
    GoRoute(
      path: '/add-note',
      name: 'addNote',
      builder: (context, state) => const NoteFormScreen(),
    ),
    GoRoute(
      path: '/edit-note',
      name: 'editNote',
      builder: (context, state) {
        final note = state.extra as NoteModel?;
        return NoteFormScreen(existingNote: note);
      },
    ),
  ],
);
