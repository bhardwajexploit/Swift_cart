import 'package:get/get.dart';
import '../../data/remote/auth_services.dart';
import 'login_controller.dart';
import 'login_repo.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService());
    Get.lazyPut<LoginRepo>(() => LoginRepo(Get.find<AuthService>()));

    // 2️⃣ register AuthService SINGLETON

    // 3️⃣ register LoginRepo
    Get.lazyPut<LoginController>(
          () => LoginController(Get.find<LoginRepo>()),
    );
  }
}
