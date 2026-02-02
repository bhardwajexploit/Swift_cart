

import 'package:foodify/screens/Register/register_controller.dart';
import 'package:foodify/screens/register/register_repo.dart';
import 'package:get/get.dart';

import '../../data/remote/auth_services.dart';

class RegisterBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<RegisterRepo>(()=>RegisterRepo(Get.find()));
    Get.lazyPut(() => RegisterController(Get.find()));

  }
}