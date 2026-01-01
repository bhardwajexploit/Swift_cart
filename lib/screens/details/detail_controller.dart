import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/product_model.dart';
import '../dashboard /dashboard_controller.dart';


class ProductDetailController extends GetxController {
  late Product product;
  final DashboardController dashboard = Get.find<DashboardController>();

  @override
  void onInit() {
    product = Get.arguments as Product;
    super.onInit();
  }

  void addToCartAndGoToCartTab() {
    debugPrint("1");
    dashboard.addToCart(product);
    dashboard.goToTab();

  }

}
