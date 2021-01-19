import 'package:Redlands_Strong/screens/screens.dart';
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
}

class ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  final AuthService auth = AuthService();
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: DesignCourseAppTheme.dismissibleBackground,
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
    User user = Provider.of<User>(context); // ref the current user status through provider

    if (user != null) {
      // if the user is logged in
      return loggedInUI(user);
    } else {
      return loggedOutUI();
    }
  }

  Widget loggedInUI(user) {
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
                      Text("logged In"),
                      Text(user.displayName ?? 'Guest'),
                      logoutButton(),
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
                        color: Colors.black45,
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

  Widget logoutButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: FlatButton.icon(
        padding: EdgeInsets.all(30),
        icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white),
        color: Colors.black45,
        onPressed: () async {
          await auth.signOut();
        },
        label: Expanded(
          child: Text('Sign Out', textAlign: TextAlign.center),
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
                  'Profile',
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

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ReviewsScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ProfileScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
