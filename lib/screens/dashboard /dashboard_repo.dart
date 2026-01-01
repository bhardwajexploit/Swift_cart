import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
 // Original ApiService with callbacks
import '../../core/constants/api_endpoints.dart';
import '../../data/remote/api_service.dart';
import '../../model/user_model.dart';
import '../../model/product_model.dart';

class DashboardRepo {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<AppUser?> getCurrentUser() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return null;

      final doc = await _db.collection('users').doc(uid).get();
      if (!doc.exists) return null;

      return AppUser.fromMap(doc.id, doc.data()!);
    } catch (e) {
      debugPrint("getCurrentUser error: $e");
      return null;
    }
  }

  /// Update name
  Future<void> updateName(String name) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    await _db.collection("users").doc(uid).update({"name": name});
  }

  /// Update password
  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final email = user.email;
    if (email == null) return;

    final credential = EmailAuthProvider.credential(email: email, password: currentPassword);
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
    await _auth.signOut();
  }

  // Products using ApiService
  Future<List<Product>> getProducts({int offset = 0, int limit = 10}) async {
    final completer = Completer<List<Product>>();

    final service = ApiService(
      url: '${ApiEndpoints.urlPRODUCTS}?offset=$offset&limit=$limit',
      data: null,
    );

    service.getRequest(
      beforeSend: () => debugPrint("🔄 Fetching products..."),
      onSuccess: (responseData) {
        try {
          if (responseData is List) {
            final products = responseData.map((json) => Product.fromMap(json)).toList();
            debugPrint("✅ Products fetched: ${products.length}");
            completer.complete(products);
          } else {
            completer.complete([]);
          }
        } catch (e) {
          debugPrint("❌ Products parsing error: $e");
          completer.complete([]);
        }
      },
      onError: (error) {
        debugPrint("❌ Products API error: $error");
        completer.complete([]);
      },
    );

    return completer.future;
  }

  Future<Product?> getProductById(int id) async {
    final completer = Completer<Product?>();

    final service = ApiService(
      url: '${ApiEndpoints.urlPRODUCTS}/$id',
      data: null,
    );

    service.getRequest(
      beforeSend: () => debugPrint("🔄 Fetching product ID: $id"),
      onSuccess: (responseData) {
        try {
          if (responseData != null) {
            final product = Product.fromMap(responseData);
            completer.complete(product);
          } else {
            completer.complete(null);
          }
        } catch (e) {
          debugPrint("❌ Product parsing error: $e");
          completer.complete(null);
        }
      },
      onError: (error) {
        debugPrint("❌ Product API error: $id - $error");
        completer.complete(null);
      },
    );

    return completer.future;
  }
}
