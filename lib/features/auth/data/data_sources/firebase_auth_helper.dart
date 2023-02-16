import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart' as domain;
import '../../domain/entities/user.dart';
import '../models/requests.dart';

const String userCollectionPath = 'Users';
const String userNameDocPath = 'name';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> loginViaEmail(LoginRequest loginRequest) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password);
    final String? userToken = await _messaging.getToken();
    if (userToken != null) {
      final user = await _firestore
          .collection(userCollectionPath)
          .doc(loginRequest.email)
          .get();
      final List userTokenList = user['userTokenList'];
      if (!userTokenList.contains(userToken)) {
        userTokenList.add(userToken);
        await _firestore
            .collection(userCollectionPath)
            .doc(loginRequest.email)
            .update({"userTokenList": userTokenList});
      }
    }
  }

  Future<UserCredential> loginViaGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<domain.UserEntities> getUser(String email) async {
    final userMap =
        (await _firestore.collection(userCollectionPath).doc(email).get())
            .data();

    if (userMap == null) {
      throw FirebaseAuthException(code: "auth/user-not-found");
    }

    return domain.UserEntities.fromMap(userMap);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> register(RegisterRequest registerRequest) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerRequest.email, password: registerRequest.password);
  }

  Future<domain.UserEntities> updateUserData(domain.UserEntities user) async {
    await _firestore
        .collection(userCollectionPath)
        .doc(user.email)
        .set(user.toMap());

    return user;
  }

  Future<domain.UserEntities> createUserDocument(User firebaseUser) async {
    return await updateUserData(domain.UserEntities.fromMap({
      'name': firebaseUser.displayName,
      'email': firebaseUser.email,
      'phoneNumber': firebaseUser.phoneNumber
    }));
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout(UserEntities user) async {
    final String? userToken = await _messaging.getToken();
    if (userToken != null) {
      final userDoc =
          await _firestore.collection(userCollectionPath).doc(user.email).get();
      final List userTokenList = userDoc['userTokenList'];
      if (userTokenList.contains(userToken)) {
        userTokenList.remove(userToken);
        await _firestore
            .collection(userCollectionPath)
            .doc(user.email)
            .update({"userTokenList": userTokenList});
      }
    }
    await _firebaseAuth.signOut();
  }
}
