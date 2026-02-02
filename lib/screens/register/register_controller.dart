import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'register_repo.dart';

class RegisterController extends GetxController {
  RegisterController(this._repo);

  final RegisterRepo _repo;

  // ---------------- TEXT CONTROLLERS ----------------
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  // ---------------- UI STATE ----------------
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // ---------------- VALIDATORS ----------------

  String? validateName(String value) {
    if (value.trim().isEmpty) return "Name cannot be empty";
    if (value.trim().length < 3) return "Name should be at least 3 characters";
    return null;
  }

  String? validateEmail(String value) {
    if (value.trim().isEmpty) return "Email is required";

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
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

  bool _runValidation() {
    final nameError = validateName(name.text);
    final emailError = validateEmail(email.text);
    final passError = validatePassword(password.text);

    error.value = nameError ?? emailError ?? passError ?? '';
    return error.value.isEmpty;
  }

  // ---------------- REGISTER ----------------

  Future<void> createUser() async {
    if (!_runValidation()) {
      Get.snackbar(
        "Invalid Details",
        error.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
      );
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      await _repo.registerUser(
        email: email.text.trim(),
        password: password.text.trim(),
        name: name.text.trim(),
      );

      Get.snackbar("Success", "Registration completed");
      Get.offNamed('/login');

    } catch (e) {
      error.value = _mapError(e);
      Get.snackbar(
        "Registration Failed",
        error.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String _mapError(Object e) {
    final msg = e.toString();
    if (msg.contains('email-already-in-use')) {
      return 'This email is already registered.';
    }
    if (msg.contains('invalid-email')) {
      return 'Invalid email address.';
    }
    if (msg.contains('weak-password')) {
      return 'Password is too weak.';
    }
    return 'Something went wrong. Please try again.';
  }

  // ---------------- CLEANUP ----------------

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.onClose();
  }
}
