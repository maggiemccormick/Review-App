import 'package:Redlands_Strong/services/services.dart';
import 'package:Redlands_Strong/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, this.animationController}) : super(key: key);
  final AnimationController animationController;

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
  static final String path = "lib/src/pages/profile/profile2.dart";
}

class ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  final AuthService auth = AuthService();
  AnimationController animationController;

  User user;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.dismissibleBackground,
  );

  @override
  void initState() {
    // to specify the app bar icon
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[1].isSelected = true; // set the profile page as selected

    animationController =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = ProfileScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    // dispose lifecycle hook
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context); // ref the current user status through provider

    if (user != null) {
      // if the user is logged in
      return loggedInUI(user);
    } else {
      return loggedOutUI();
    }
  }

  Widget loggedInUI(user) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.nearlyBlue, AppTheme.nearlyDarkBlue]),
            ),
          ),
          ListView.builder(
            itemCount: 6,
            itemBuilder: _mainListBuilder,
          ),
        ],
      ),
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    print(index);
    if (index == 0) return _buildHeader(context);
    if (index == 1) return _buildReviewsSection(context);
    if (index == 2) return _buildFavouritesSection(context);
    if (index == 3) return _buildFriendsSection(context);
    if (index == 4) return logoutButton();
    return _buildListItem();
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    user.displayName ?? 'Guest',
                    //user.displayName ?? 'Guest',
                    style: AppTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    // description of user
                    user.email ?? 'email@gmail.com',
                    style: AppTheme.subtitle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 30.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "30",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Reviews".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: AppTheme.body2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "12",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Favourites".toUpperCase(),
                                textAlign: TextAlign.center, style: AppTheme.body2),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                        NetworkImage(user.photoURL) ?? AssetImage("assets/images/userImage.png")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildReviewsSection(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Text(
              "Reviews",
              style: AppTheme.title,
            ),
          )
        ],
      ),
    );
  }

  Container _buildFavouritesSection(BuildContext context) {
    return Container(
        height: 250,
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
        child: Text("Favourite locations", style: AppTheme.title));
  }

  Container _buildFriendsSection(BuildContext context) {
    return Container(
        height: 250,
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
        child: Text("Friends", style: AppTheme.title));
  }

  Widget _buildListItem() {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ClipRRect(
        child: SizedBox(
          height: 50.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
        //child: PNetworkImage(images[2], fit: BoxFit.cover), FIX THIS LINE
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppTheme.nearlyBlue, AppTheme.nearlyDarkBlue]),
      ),
      margin: EdgeInsets.only(bottom: 10, top: 10),
      child: ClipRRect(
        child: FlatButton.icon(
          padding: EdgeInsets.all(30),
          icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white),
          onPressed: () async {
            await auth.signOut();
          },
          label: Expanded(
            child: Text(
              'Sign Out',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  Widget loggedOutUI() {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Text("Logged Out"),
                      LoginButton(
                        text: 'LOGIN WITH GOOGLE',
                        icon: FontAwesomeIcons.google,
                        loginMethod: auth.googleSignIn,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Profile Page',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: Image.asset('assets/review_app/redlands_strong_icon_temp.png'),
          )
        ],
      ),
    );
  }
}
