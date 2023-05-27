import 'package:cinema_app/screens/log_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinema_app/utils/showSnackBar.dart';

import '../screens/dashboard.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.sendEmailVerification();

      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Email verification link has been sent.');

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists with the provided email.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      showSnackBar(context, e.message!);
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        // User is logged in and email is verified, navigate to the home screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PageViewExample()),
          (route) => false,
        );
      } else {
        // Implement additional logic for handling unverified users
        // e.g., restrict access to certain features, show a verification message, etc.
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        showSnackBar(context, 'Invalid email or password');
      } else {
        showSnackBar(context, e.message!);
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }
}
