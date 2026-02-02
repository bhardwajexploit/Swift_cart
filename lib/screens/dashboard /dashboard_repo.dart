import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../../data/remote/api_service.dart';
import '../../data/remote/auth_services.dart';
import '../../model/product_model.dart';
import '../../model/user_model.dart';

class DashboardRepo {
  final AuthService _authService;
  final ApiService _apiService;

  DashboardRepo(this._authService, this._apiService);

  // -------------------- USER --------------------

  Future<AppUser?> getCurrentUser() async {
    try {
      final uid = _authService.uid;
      if (uid == null) return null;

      final doc = await _authService.firestore
          .collection('users')
          .doc(uid)
          .get();

      if (!doc.exists) return null;

      return AppUser.fromMap(doc.id, doc.data()!);
    } catch (e) {
      debugPrint("❌ [DashboardRepo] getCurrentUser error: $e");
      return null;
    }
  }

  Future<void> updateName(String name) async {
    final uid = _authService.uid;
    if (uid == null) return;

    await _authService.firestore
        .collection("users")
        .doc(uid)
        .update({"name": name});
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _authService.changePassword(newPassword, currentPassword: currentPassword);
  }

  // -------------------- PRODUCTS --------------------

  Future<List<Product>> getProducts() async {
    final completer = Completer<List<Product>>();

    _apiService.getRequest(
      beforeSend: () =>
          debugPrint("🔄 [DashboardRepo] Fetching products"),
      onSuccess: (responseData) {
        try {
          if (responseData is Map &&
              responseData['products'] is List) {
            final list = responseData['products'] as List;

            final products =
            list.map((e) => Product.fromMap(e)).toList();

            completer.complete(products);
          } else {
            debugPrint("⚠️ [DashboardRepo] Invalid product response");
            completer.complete([]);
          }
        } catch (e) {
          debugPrint("❌ [DashboardRepo] Product parse error: $e");
          completer.complete([]);
        }
      },
      onError: (error) {
        debugPrint("❌ [DashboardRepo] Product API error: $error");
        completer.complete([]);
      },
    );

    return completer.future;
  }

  Future<Product?> getProductById(int id) async {
    final completer = Completer<Product?>();

    _apiService.getRequest(
      beforeSend: () =>
          debugPrint("🔄 [DashboardRepo] Fetching product ID: $id"),
      onSuccess: (responseData) {
        try {
          completer.complete(
            responseData != null
                ? Product.fromMap(responseData)
                : null,
          );
        } catch (e) {
          debugPrint("❌ [DashboardRepo] Product parse error: $e");
          completer.complete(null);
        }
      },
      onError: (error) {
        debugPrint("❌ [DashboardRepo] Product API error: $error");
        completer.complete(null);
      },
    );

    return completer.future;
  }
}
