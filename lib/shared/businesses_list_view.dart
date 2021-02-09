import 'package:Redlands_Strong/main.dart';
import 'package:Redlands_Strong/services/models.dart';
import 'package:Redlands_Strong/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This class contains the widget for the list of reviews for each category

class BusinessesListView extends StatefulWidget {
  const BusinessesListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;

  @override
  _BusinessesListViewState createState() => _BusinessesListViewState();
}

class _BusinessesListViewState extends State<BusinessesListView> with TickerProviderStateMixin {
  AnimationController animationController;
  var businesses;

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
    businesses = Provider.of<List<Business>>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
          itemCount: businesses.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            final int count = businesses.length > 10 ? 10 : businesses.length;
            final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController,
                    curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
            animationController.forward();

            // The individual business card with the index, animations and callback when clicked
            return BusinessView(
              business: businesses[index],
              animation: animation,
              animationController: animationController,
              callback: () {
                widget.callBack();
              },
            );
          },
        ),
      ),
    );
  }
}

/// This class acts as the containing widget for the individual business card
/// and associated information
class BusinessView extends StatelessWidget {
  const BusinessView(
      {Key key, this.business, this.animationController, this.animation, this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Business business; // the individual business object (typed to Business) at pos i in array
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
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        // row for the review cards
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.lightestOrange,
                                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                gradient: new LinearGradient(colors: [AppTheme.lightOrange, AppTheme.lightPink],
                                        begin: Alignment.centerLeft, end: Alignment.centerRight, tileMode: TileMode.clamp),
                                boxShadow: [  // for some reason this looks really ugly in the rows with mult businesses?
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3, //spread radius
                                    blurRadius: 5, // blur radius
                                    offset: Offset(0, 2), // changes position of shadow
                                    //first parameter of offset is left-right
                                    //second parameter is top to down
                                  //you can set more BoxShadow() here
                                  ),
                                ],
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    // widget containing business card information
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 16),
                                            child: Text(
                                              business.name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 16, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${business.numReviews} Reviews',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: AppTheme.grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${business.rating}',
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
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16, right: 16),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Value: ${business.value}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: AppTheme.nearlyBlue,
                                                  ),
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: AppTheme.nearlyBlue,
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
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0, child: Image.network(business.image)),
                            )
                          ],
                        ),
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
