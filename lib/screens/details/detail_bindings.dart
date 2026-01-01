
import 'package:foodify/screens/details/detail_controller.dart';
import 'package:get/get.dart';

class DetailBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<ProductDetailController>(ProductDetailController());
  }

}