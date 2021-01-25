import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
      updateUserData(user);
      return user;
    } catch (error) {
      print("There was an error logging in");
      print(error);
      return null;
    }
  }

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(User user) {
    // reference the users document
    DocumentReference userRef = _db.collection('users').doc(user.uid);
    try {
      return userRef.set(// data payload we wish to save
          {
        'uid': user.uid,
        'email': user.email,
        'profilePhoto': user.photoURL,
      }, SetOptions(merge: true)); // merge true in order to not overwrite data
    } catch (err) {
      stderr.writeln('Error entering user into database $err');
    }
  }

  // Sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}
