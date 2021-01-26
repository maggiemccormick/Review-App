import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// This class acts as the data model for the bottom bar tabs
class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/review_app/tab_1.png',
      selectedImagePath: 'assets/review_app/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/review_app/tab_4.png',
      selectedImagePath: 'assets/review_app/tab_4s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
  ];
}

/// This class acts as the data model for a user
class UserData {
  final String bio;
  final List<dynamic> friends;
  final List<dynamic> favourites;

  UserData({
    this.bio,
    this.friends,
    this.favourites,
  });

  factory UserData.fromFirestore(Map data) {
    data = data ?? {};
    // default values in case none exist from firestore
    return UserData(
        bio: data['bio'] ?? 'User Bio',
        friends: data['friends'] ?? [''],
        favourites: data['favourites'] ?? ['']);
  }
}

/// This class acts as the data model for all of the businesses
class Business {
  final double atmosphere;
  final String category;
  final String id;
  final String image;
  final String location;
  final String name;
  final int numReviews;
  final int phoneNumber;
  final double rating;
  final double service;
  final double value;

  Business(
      {this.atmosphere,
      this.category,
      this.id,
      this.image,
      this.location,
      this.name,
      this.numReviews,
      this.phoneNumber,
      this.rating,
      this.service,
      this.value});

  factory Business.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data();

    // default values in case none exist from firestore
    return Business(
        atmosphere: data['atmosphere'] ?? 0.0,
        category: data['category'] ?? '',
        id: doc.id,
        image: data['image'] ?? 'assets/design_course/interFace1.png',
        location: data['location'] ?? '',
        name: data['name'] ?? '',
        numReviews: data['numReviews'] ?? 0,
        phoneNumber: data['phoneNumber'] ?? 0.0,
        rating: data['rating'] ?? 0.0,
        service: data['service'] ?? 0.0,
        value: data['value'] ?? 0.0);
  }
}

class Category {
  final String name;

  Category({this.name});
}
