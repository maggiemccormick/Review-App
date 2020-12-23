import 'package:Redlands_Strong/review_app/profile_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: ProfilePage(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: ProfilePage(),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: ProfilePage(),
    ),
  ];
}
