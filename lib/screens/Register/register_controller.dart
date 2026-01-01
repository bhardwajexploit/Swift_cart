import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/remote/authservice.dart';
import 'register_repo.dart';

class RegisterController extends GetxController {

  final RegisterRepo _repo = RegisterRepo();
  final Authservice _authService = Authservice();

  // Text Controllers
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  // UI State
  final isPasswordVisible = false.obs;
  final _loading = false.obs;
  final _error = ''.obs;

  bool get loading => _loading.value;
  String get error => _error.value;

  // ---------------- VALIDATORS ---------------- //

  String? validateName(String value) {
    if (value.trim().isEmpty) return "Name cannot be empty";
    if (value.trim().length < 3) return "Name should be at least 3 characters";
    return null;
  }

  String? validateEmail(String value) {
    if (value.trim().isEmpty) return "Email is required";

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";

    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasLower = value.contains(RegExp(r'[a-z]'));
    final hasDigit = value.contains(RegExp(r'[0-9]'));

    if (!hasUpper || !hasLower || !hasDigit) {
      return "Password must include upper, lower and number";
    }
    return null;
  }

  bool runFormValidation() {
    final nameError = validateName(name.text);
    final emailError = validateEmail(email.text);
    final passError = validatePassword(password.text);

    if (nameError != null) {
      _error.value = nameError;
      return false;
    }
    if (emailError != null) {
      _error.value = emailError;
      return false;
    }
    if (passError != null) {
      _error.value = passError;
      return false;
    }

    _error.value = "";
    return true;
  }

  // ---------------- REGISTER ---------------- //

  Future<void> createUser() async {

    if (!runFormValidation()) {
      Get.snackbar("Invalid Details", _error.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.purple);
      return;
    }

    _loading.value = true;
    _error.value = '';

    try {
      final credential = await _authService.registerUser(
        email: email.text.trim(),
        password: password.text.trim(),
        name: name.text.trim(),
      );

      if (credential?.user != null) {
        await _repo.createUser(
          uid: credential!.user!.uid,
          name: name.text.trim(),
          email: email.text.trim(),
        );
      }

      Get.snackbar("Success", "Registration completed");
      Get.toNamed('/login');

    } on FirebaseAuthException catch (e) {
      _error.value = _mapFirebaseError(e);
      Get.snackbar(
        'Registration failed',
        _error.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
      );
    } catch (_) {
      _error.value = 'Something went wrong. Please try again.';
      Get.snackbar('Error', _error.value,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      _loading.value = false;
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'Password is too weak.';
      default:
        return e.message ?? 'Unknown error occurred.';
    }
  }
}
