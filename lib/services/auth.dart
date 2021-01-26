import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'db.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = DatabaseService();

  // Firebase user a realtime stream
  Stream<User> get user => _auth.authStateChanges();

  /// Sign in with Google
  Future<User> googleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      User user = result.user;

      // Update user data in firestore
      db.updateUserData(user);
      return user;
    } catch (error) {
      print("There was an error logging in");
      print(error);
      return null;
    }
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}
