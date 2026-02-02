
import 'package:get/get.dart';
import '../../data/remote/auth_services.dart';
import '../../data/remote/api_service.dart';
import '../../core/constants/api_endpoints.dart';
import 'dashboard_repo.dart';
import 'dashboard_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());

    Get.lazyPut<ApiService>(
          () => ApiService(
        url: ApiEndpoints.urlPRODUCTS,
        data: null,
      ),
    );

Get.lazyPut<DashboardRepo>(()=> DashboardRepo(Get.find(), Get.find()));
    Get.lazyPut<DashboardController>(
          () => DashboardController(Get.find<DashboardRepo>()),
    );
  }
}
