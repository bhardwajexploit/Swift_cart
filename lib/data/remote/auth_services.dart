import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // -------------------- SINGLETON --------------------

  AuthService._internal();

  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  // -------------------- DEPENDENCY --------------------

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  // -------------------- GETTERS --------------------

  User? get currentUser => _firebaseAuth.currentUser;
  FirebaseFirestore get firestore => _firebaseFirestore;
  String? get uid => _firebaseAuth.currentUser?.uid;

  Stream<User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  // -------------------- REGISTER --------------------

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    debugPrint('📧 [AuthService] Registering user');

    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // -------------------- LOGIN --------------------

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    debugPrint('🔐 [AuthService] Logging in');

    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // -------------------- LOGOUT --------------------

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    debugPrint('🚪 [AuthService] Logged out');
  }

  // -------------------- PASSWORD --------------------

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(String newPassword, {required String currentPassword}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw Exception("No user logged in");

    await user.updatePassword(newPassword);
  }

  // -------------------- EMAIL --------------------

  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    await user.sendEmailVerification();
  }

  // -------------------- DELETE --------------------

  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    await user.delete();
  }
}
