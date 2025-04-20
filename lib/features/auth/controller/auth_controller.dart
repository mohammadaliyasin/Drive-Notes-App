import 'package:drive_notes_app/services/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});

class AuthController extends StateNotifier<bool> {
  final AuthService authService;

  AuthController(this.authService) : super(false);

  Future<void> signIn() async {
    final success = await authService.signInWithGoogle();
    state = success;
  }

  Future<void> signOut() async {
    await authService.signOut();
    state = false;
  }

  bool get isSignedIn => state;
}