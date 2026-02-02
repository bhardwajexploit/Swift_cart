import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';
import '../../model/cart_model.dart';
import '../../model/user_model.dart';
import 'dashboard_repo.dart';

class DashboardController extends GetxController {
  /// Repo (LOOSE COUPLING)
  final DashboardRepo repo;
  DashboardController(this.repo);

  /// UI State
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt tabIndex = 0.obs;

  /// User
  final Rx<AppUser?> user = Rx<AppUser?>(null);
  final nameController = ''.obs;

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController currentPasswordTextController =
  TextEditingController();

  /// Profile UI state
  final RxBool isPasswordVisible = false.obs;

  /// Products
  final RxList<Product> productsList = <Product>[].obs;

  /// Cart
  final RxList<CartItem> cartItems = <CartItem>[].obs;

  // -------------------- LIFECYCLE --------------------

  @override
  void onInit() {
    super.onInit();
    loadUser();
    fetchAllProducts();
  }

  // -------------------- TAB --------------------

  void changeTab(int index) {
    if (index >= 0 && index <= 2) {
      tabIndex.value = index;
    }
  }

  void goToCartTab() {
    Get.until((route) => route.isFirst);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeTab(1);
    });
  }


  // -------------------- PROFILE UI --------------------

  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  // -------------------- USER --------------------

  Future<void> loadUser() async {
    isLoading.value = true;

    try {
      user.value = await repo.getCurrentUser();

      if (user.value != null) {
        nameController.value = user.value!.name;
        nameTextController.text = user.value!.name;
      }
    } catch (_) {
      Get.snackbar("Error", "Failed to load profile");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateName() async {
    final newName = nameTextController.text.trim();
    if (newName.isEmpty) return;

    isLoading.value = true;

    try {
      await repo.updateName(newName);
      nameController.value = newName;
      await loadUser();
      Get.snackbar("Success", "Name updated");
    } catch (_) {
      Get.snackbar("Error", "Update failed");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword() async {
    final currentPw = currentPasswordTextController.text.trim();
    final newPw = passwordTextController.text.trim();

    if (currentPw.isEmpty || newPw.isEmpty) return;

    isLoading.value = true;

    try {
      await repo.updatePassword(
        currentPassword: currentPw,
        newPassword: newPw,
      );

      currentPasswordTextController.clear();
      passwordTextController.clear();

      Get.snackbar("Success", "Password updated");
      await logout();
    } catch (_) {
      Get.snackbar("Error", "Password update failed");
    } finally {
      isLoading.value = false;
    }
  }

  // -------------------- PRODUCTS --------------------

  Future<void> fetchAllProducts() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final products = await repo.getProducts(

      );

      productsList.assignAll(products);
       log('${productsList.length}');

      if (products.isEmpty) {
        errorMessage.value = "No products found";
      }
    } catch (_) {
      errorMessage.value = "Failed to load products";
      productsList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await fetchAllProducts();
  }

  // -------------------- CART --------------------

  void addToCart(Product product) {
    final index =
    cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  double get totalPrice => cartItems.fold(
    0,
        (sum, item) => sum + (item.price * item.quantity),
  );

  // -------------------- CHECKOUT --------------------

  Future<void> checkout() async {
    if (cartItems.isEmpty) {
      Get.snackbar("Empty Cart", "Add items to checkout");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    cartItems.clear();
    isLoading.value = false;

    Get.snackbar(
      "Order Placed ✅",
      "Your order is on the way",
      duration: const Duration(seconds: 3),
    );
  }

  // -------------------- AUTH --------------------

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed("/welcome");
  }

  // -------------------- CLEANUP --------------------

  @override
  void onClose() {
    nameTextController.dispose();
    passwordTextController.dispose();
    currentPasswordTextController.dispose();
    super.onClose();
  }
}
