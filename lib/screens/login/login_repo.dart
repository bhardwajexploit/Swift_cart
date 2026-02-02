import 'package:firebase_auth/firebase_auth.dart';
import '../../data/remote/auth_services.dart';

class LoginRepo {
  final AuthService _authService;

  LoginRepo(this._authService);

  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _authService.login(
      email: email,
      password: password,
    );
  }
}
