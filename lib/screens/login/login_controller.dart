
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
import 'package:foodify/screens/login/login_repo.dart';
  import 'package:get/get.dart';

  class LoginController extends GetxController {
   final LoginRepo _repo;
     LoginController(this._repo);
    var isPasswordVisible = false.obs;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final RxBool isLoading = false.obs;

    bool get loading => isLoading.value;
    Future<void> loginUser() async {
      isLoading.value = true;
      try {
        final cred = await _repo.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        debugPrint('✅ [LOGIN] SUCCESS! UID: ${cred.user?.uid}');

        Get.offAllNamed('/home');

      } on FirebaseAuthException catch (e) {
        debugPrint('❌ [LOGIN] FirebaseAuthException: ${e.code} - ${e.message}');
        Get.snackbar(
          '${e.message}',
          e.code,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      } catch (e) {
        debugPrint('❌ [LOGIN] Unknown error: $e');
        Get.snackbar('Error', "unknown", backgroundColor: Colors.red);
      } finally {
        isLoading.value = false;
        debugPrint('🏁 [LOGIN] Login process completed');
      }
    }
  }
