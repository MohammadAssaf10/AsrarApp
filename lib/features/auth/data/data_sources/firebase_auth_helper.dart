import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart' as domain;
import '../models/requests.dart';

const String userCollectionPath = 'Users';
const String userNameDocPath = 'name';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> loginViaEmail(LoginRequest loginRequest) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: loginRequest.email, password: loginRequest.password);
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

  Future<domain.User> updateUserData(domain.User user) async {
    await _firestore
        .collection(userCollectionPath)
        .doc(user.email)
        .set(user.toMap());

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

  logout() async {
    await _firebaseAuth.signOut();
  }
}
