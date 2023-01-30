import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user.dart' as domain;
import '../models/requests.dart';

const String userCollectionPath = 'Users';
const String userNameDocPath = 'name';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(LoginRequest loginRequest) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password);
  }

  Future<domain.User> getUser(String email) async {
    final userMap =
        (await _firestore.collection(userCollectionPath).doc(email).get())
            .data();

    if (userMap == null) {
      throw FirebaseAuthException(code: "auth/user-not-found");
    }

    return domain.User.fromMap(userMap);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> register(RegisterRequest registerRequest) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerRequest.email, password: registerRequest.password);
  }

  Future<void> updateUserData(domain.User user) async {
    await _firestore.collection(userCollectionPath).doc(user.email).set(user.toMap());
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
