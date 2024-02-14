import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthHelper extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserCredential? userCredential;

  Future<void> login(String email, String password) async {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signup(String email, String password) async {
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  bool get isLoggedIn => _auth.currentUser?.uid != null;
}
