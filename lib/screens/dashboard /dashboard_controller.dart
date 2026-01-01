import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/model/cart_model.dart';
import 'package:get/get.dart';
import '../../core/constants/api_endpoints.dart';
import '../../model/product_model.dart';
import '../../model/user_model.dart';
import 'dashboard_repo.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;
  final RxBool isPasswordVisible = false.obs;
  late CupertinoTabController tabController;
  /// Product Variables
  final RxList<Product> productsList = <Product>[].obs;
  final RxBool productsLoading = false.obs;
  final RxString productsError = ''.obs;
  final DashboardRepo _repo = DashboardRepo();



  /// cart
  final cartItems = <CartItem>[].obs;

  void addToCart(Product product) {
    final index = cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh(); // notify UI
      debugPrint("🔁 Increased qty: ${cartItems[index].quantity}");
    } else {
      cartItems.add(CartItem(product: product));
      debugPrint("🛒 Added new item: ${product.title}");
    }

    debugPrint("🛍 Cart Count: ${cartItems.length}");
  }
  double get totalPrice => cartItems.fold(
    0,
        (sum, item) => sum + (item.price * item.quantity),
  );


  RxBool isLoading = false.obs;
  Rx<AppUser?> user = Rx<AppUser?>(null);

  final nameController = RxString("");
  final passwordController = RxString("");
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController currentPasswordTextController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    loadUser();
    fetchAllProducts();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  void changeTab(int index) {
    if (index >= 0 && index <= 2) {
      tabController.index = index;  // Con
      tabIndex.value = index;
      update();
    }
  }

  void goToTab() {
    Get.until((route) => route.isFirst);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changeTab(1);  // Cart (index 1)
    });
  }




  /// loadusers
  Future<void> loadUser() async {
    try {
      isLoading.value = true;

      // First attempt
      user.value = await _repo.getCurrentUser();

      // If null, wait & retry (first login case)
      if (user.value == null) {
        await Future.delayed(const Duration(milliseconds: 400));
        user.value = await _repo.getCurrentUser();
      }

      // Sync UI if user exists
      if (user.value != null) {
        nameController.value = user.value!.name;
        nameTextController.text = user.value!.name;
      }

    } catch (e) {
      Get.snackbar("Error", "Failed to load profile");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchAllProducts({int offset = 0, int limit = 20}) async {
    print("\n🚀🚀🚀 [CONTROLLER] fetchAllProducts STARTED 🚀🚀🚀");
    print("📡 URL: ${ApiEndpoints.urlPRODUCTS}?offset=$offset&limit=$limit");

    productsLoading.value = true;
    productsError.value = '';

    try {
      // Call your repo function
      final products = await _repo.getProducts(offset: offset, limit: limit);

      print("\n✅✅✅ [API DATA] Raw products count: ${products.length}");

      // Log first few products details
      for (int i = 0; i < products.length && i < 3; i++) {
        final p = products[i];
        print("📦 Product ${i+1}: ${p.title} | ₹${p.price} | ${p.category.name}");
      }

      productsList.value = products;

      print("\n🎉🎉🎉 [SUCCESS] ${products.length} products loaded to UI!");

      if (products.isEmpty) {
        productsError.value = "No products found";
        print("⚠️ No products returned from API");
      }

    } catch (e) {
      print("\n❌❌❌ [ERROR] fetchAllProducts failed: $e");
      productsError.value = "Failed to load products";
      productsList.clear();
    } finally {
      productsLoading.value = false;
      print("🏁 [END] fetchAllProducts completed\n");
    }
  }

  Future<void> refreshProducts() async {
    await fetchAllProducts(offset: 0, limit: 20);
  }


  Future<void> fetchProduct(int id) async {
    print("\n🔍 [SINGLE] Fetching product ID: $id");
    final product = await _repo.getProductById(id);
    if (product != null) {
      print("✅ [SINGLE] ${product.title} | ₹${product.price}");
    } else {
      print("❌ [SINGLE] Product $id not found");
    }
  }




  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed("/welcome");
  }

  Future<void> updateName() async {
    try {
      final newName = nameTextController.text.trim();

      if (newName.isEmpty) {
        Get.snackbar("Invalid", "Name cannot be empty");
        return;
      }

      await _repo.updateName(newName);

      nameController.value = newName;   // keep Rx in sync

      await loadUser();                 // refresh profile

      Get.snackbar("Updated", "Name updated successfully");

    } catch (_) {
      Get.snackbar("Error", "Failed to update name");
    }
  }


  Future<void> changePassword() async {
    try {
      final currentPw = currentPasswordTextController.text.trim();
      final newPw = passwordTextController.text.trim();

      if (currentPw.isEmpty || newPw.isEmpty) {
        Get.snackbar("Invalid", "Both fields are required");
        return;
      }

      await _repo.updatePassword(
        currentPassword: currentPw,
        newPassword: newPw,
      );

      // Clear fields
      currentPasswordTextController.clear();
      passwordTextController.clear();

      Get.snackbar("Success", "Password updated. Please login again");

      // 🔐 Logout after password change
      await logout();

    } catch (e) {
      Get.snackbar("Error", "Password update failed");
    }
  }


  Future<void> checkout() async {
    if (cartItems.isEmpty) {
      Get.snackbar(
        "Empty Cart",
        "Add items to checkout",
        snackPosition: SnackPosition.TOP,
        backgroundColor: CupertinoColors.systemRed,
        colorText: CupertinoColors.white,
      );
      return;
    }


    await Future.delayed(Duration(seconds: 1));

    cartItems.clear();

    // Success feedback
    Get.snackbar(
      "Order Placed! ✅",
      "Your Order is on the Way",
      snackPosition: SnackPosition.TOP,
      backgroundColor: CupertinoColors.white,
      colorText: CupertinoColors.black,

      duration: Duration(seconds: 3),
    );

    print("🛒 Checkout complete - Cart cleared: ${cartItems.length} items");
  }

}
