import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models.dart';

/// This class acts as the database managing service which will contain all the CRUD functions
class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User user;

  /// Query a list of Business documents
  Stream<List<Business>> streamBusinesses(category) {
    var ref = _db.collection('businesses').where('category', isEqualTo: category);
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => Business.fromFirestore(doc)).toList());
  }

  /// Updates the User's data in Firestore on each new login
  Future<void> updateUserData(User user) {
    // reference the users document
    DocumentReference userRef = _db.collection('users').doc(user.uid);
    this.user = user;
    try {
      return userRef.set(// data payload we wish to save
          {
        'uid': user.uid,
        'email': user.email,
        'profilePhoto': user.photoURL,
        'bio': '',
        'friends': [''],
        'favourites': [''],
      }, SetOptions(merge: true)); // merge true in order to not overwrite data
    } catch (err) {
      stderr.writeln('Error entering user into database $err');
      return null;
    }
  }

  /// Get a stream of a single user document
  /// id: String - The users doc ID
  Stream<UserData> streamUserData(String id) {
    return _db
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snap) => UserData.fromFirestore(snap.data()));
  }
}
