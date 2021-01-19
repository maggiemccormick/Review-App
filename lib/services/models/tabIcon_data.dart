import 'package:flutter/material.dart';

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
