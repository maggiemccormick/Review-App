import 'package:Redlands_Strong/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A reusable login button for multiple auth methods
class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppTheme.nearlyBlue, AppTheme.nearlyDarkBlue]),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        child: FlatButton.icon(
          padding: EdgeInsets.all(30),
          icon: Icon(icon, color: Colors.white),
          onPressed: () async {
            var user = await loginMethod();
            if (user != null) {
              print("user logged in as ${user.displayName}");
            }
          },
          label: Expanded(
            child: Text('$text', textAlign: TextAlign.center),
          ),
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
