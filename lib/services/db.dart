import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

/// This class acts as the database managing service which will contain all the CRUD functions
class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Query a list of Business documents
  Stream<List<Business>> streamBusinesses(category) {
    var ref = _db.collection('businesses').where('category', isEqualTo: category);
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => Business.fromFirestore(doc)).toList());
  }
}
