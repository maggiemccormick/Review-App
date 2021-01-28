import 'package:Redlands_Strong/services/models.dart';
import 'package:Redlands_Strong/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This class contains the widget for the list of reviews for each category

class ReviewsListView extends StatefulWidget {
  @override
  _ReviewsListViewState createState() => _ReviewsListViewState();
}

class _ReviewsListViewState extends State<ReviewsListView> with TickerProviderStateMixin {
  AnimationController animationController;
  var reviews;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    reviews = Provider.of<List<Review>>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 220,
        width: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
          itemCount: reviews.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final int count = reviews.length > 10 ? 10 : reviews.length;
            final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
            animationController.forward();

            // The individual business card with the index, animations and callback when clicked
            return ReviewsView(
              reviews: reviews[index],
              animation: animation,
              animationController: animationController,
            );
          },
        ),
      ),
    );
  }
}

/// This class acts as the containing widget for the individual business card
/// and associated information
class ReviewsView extends StatelessWidget {
  const ReviewsView({Key key, this.reviews, this.animationController, this.animation})
      : super(key: key);

  final Review reviews; // the individual business object (typed to Business) at pos i in array
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: AppTheme.nearlyBlue,
              child: SizedBox(
                width: 350,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        // row for the review cards
                        children: <Widget>[
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Material(
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              elevation: 5.0,
                              color: AppTheme.nearlyWhite,
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Expanded(
                                    // widget containing business card information
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  reviews.businessName,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    letterSpacing: 0.27,
                                                    color: AppTheme.darkerText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${reviews.rating}',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w200,
                                                          fontSize: 18,
                                                          letterSpacing: 0.27,
                                                          color: AppTheme.grey,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: AppTheme.nearlyBlue,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16, bottom: 8, top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Posted on:',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.27,
                                                        color: AppTheme.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      reviews.datePosted,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.27,
                                                        color: AppTheme.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5, right: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Review:",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        letterSpacing: 0.28,
                                                        color: AppTheme.nearlyBlue,
                                                      ),
                                                    ),
                                                    Text(
                                                      reviews.review,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w200,
                                                        fontSize: 12,
                                                        letterSpacing: 0.2,
                                                        color: AppTheme.darkerText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5, right: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Value: ${reviews.value}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: AppTheme.nearlyBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 5, right: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Atmosphere: ${reviews.atmosphere}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: AppTheme.nearlyBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10, right: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Service: ${reviews.service}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: AppTheme.nearlyBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
