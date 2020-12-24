// this class acts as the data model for all of the reviews

class Review {
  Review({
    this.title = '',
    this.imagePath = '',
    this.numReviews = 0,
    this.money = '\$',
    this.rating = 0.0,
  });

  String title;
  int numReviews;
  String money;
  double rating;
  String imagePath;

  static List<Review> categoryList = <Review>[
    Review(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      numReviews: 24,
      money: '\$\$',
      rating: 4.3,
    ),
    Review(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      numReviews: 22,
      money: '\$\$',
      rating: 4.6,
    ),
    Review(
      imagePath: 'assets/design_course/interFace1.png',
      title: 'User interface Design',
      numReviews: 24,
      money: '\$\$',
      rating: 4.3,
    ),
    Review(
      imagePath: 'assets/design_course/interFace2.png',
      title: 'User interface Design',
      numReviews: 22,
      money: '\$\$',
      rating: 4.6,
    ),
  ];

  static List<Review> popularCourseList = <Review>[
    Review(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'App Design Course',
      numReviews: 12,
      money: '\$\$',
      rating: 4.8,
    ),
    Review(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Web Design Course',
      numReviews: 28,
      money: '\$\$',
      rating: 4.9,
    ),
    Review(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'App Design Course',
      numReviews: 12,
      money: '\$\$',
      rating: 4.8,
    ),
    Review(
      imagePath: 'assets/design_course/interFace4.png',
      title: 'Web Design Course',
      numReviews: 28,
      money: '\$\$',
      rating: 4.9,
    ),
  ];
}
