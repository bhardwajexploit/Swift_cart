
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/remote/auth_services.dart';

class RegisterRepo {
  final AuthService _authService;

  RegisterRepo(this._authService);

  Future<UserCredential> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    // 1️⃣ Create auth user
    final credential = await _authService.register(
      email: email,
      password: password,
    );

    // 2️⃣ Create profile in Firestore
    await _authService.firestore.collection('users').doc(
      credential.user!.uid,
    ).set({
      'uid': credential.user!.uid,
      'name': name,
      'email': email,
      'createdAt': DateTime.now(),
    });

    return credential;
  }
}
