import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/entities.dart' as entities;
import '../models/requests.dart';
import '../models/responses.dart';

const String userCollectionPath = 'Users';
const String userNameDocPath = 'name';
const String userPhoneNumberDocPath = 'phone';

class FirebaseHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(LoginRequest loginRequest) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password);
  }

  Future<UserResponse> getUserData(String email) async {
    UserResponse userResponse = UserResponse();

    final doc =
        await _firestore.collection(userCollectionPath).doc(email).get();

    userResponse.name = doc[userNameDocPath];
    userResponse.phoneNumber = doc[userPhoneNumberDocPath];

    return userResponse;
  }

  Future<void> register(RegisterRequest registerRequest) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerRequest.email, password: registerRequest.password);
  }

  Future<void> updateUserData(entities.User user) async {
    await _firestore.collection(userCollectionPath).doc(user.email).set({
      userNameDocPath: user.name,
      userPhoneNumberDocPath: user.mobileNumber
    });
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
