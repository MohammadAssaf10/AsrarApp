import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart' as domain;
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

  Future<User?> loginViaEmail(LoginRequest loginRequest) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password)).user;
  }

  Future<UserCredential> loginViaGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<domain.User> getUser(String email) async {
    final userMap = (await _firestore.collection(userCollectionPath).doc(email).get()).data();

    if (userMap == null) {
      throw FirebaseAuthException(code: "auth/user-not-found");
    }

    return domain.User.fromMap(userMap);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User?> register(RegisterRequest registerRequest) async {
    return( await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerRequest.emailG, password: registerRequest.password)).user;
  }

  Future<domain.User> updateUserData(domain.User user) async {
    await _firestore.collection(userCollectionPath).doc(user.id).set(user.toMap());

    return user;
  }

  Future<domain.User> createUserDocument(User firebaseUser) async {
    return await updateUserData(domain.User.fromMap({
      'name': firebaseUser.displayName,
      'email': firebaseUser.email,
      'phoneNumber': firebaseUser.phoneNumber
    }));
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout(String userEmail) async {
    await _firebaseAuth.signOut();
  }

  Future<List<String>> createAndAddToUserListToken(String userEmail, String? token) async {
    List<String> userListToken = [];
    if (token != null) userListToken.add(token);
    await _firestore
        .collection(userCollectionPath)
        .doc(userEmail)
        .set({'userTokenList': userListToken});

    return userListToken;
  }

  Future<List<String>> addUserToken(String userEmail) async {
    final String? userToken = await _messaging.getToken();
    final userDoc = await _firestore.collection(userCollectionPath).doc(userEmail).get();

    try {
      final List<String> userTokenList = userDoc['userTokenList']?.cast<String>() ?? [];

      if (userToken != null && !userTokenList.contains(userToken)) {
        userTokenList.add(userToken);
        await _firestore
            .collection(userCollectionPath)
            .doc(userEmail)
            .update({"userTokenList": userTokenList});
      }

      return userTokenList;
    } catch (e) {
      return createAndAddToUserListToken(userEmail, userToken);
    }
  }

  Future<void> deleteUserToken(String userEmail) async {
    final String? userToken = await _messaging.getToken();
    if (userToken != null) {
      final userDoc = await _firestore.collection(userCollectionPath).doc(userEmail).get();
      final List userTokenList = userDoc['userTokenList'];
      if (userTokenList.contains(userToken)) {
        userTokenList.remove(userToken);
        await _firestore
            .collection(userCollectionPath)
            .doc(userEmail)
            .update({"userTokenList": userTokenList});
      }
    }
  }
}
