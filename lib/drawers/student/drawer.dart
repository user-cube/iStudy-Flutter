import 'package:flutter/material.dart';
import 'package:istudy/app.dart';
import 'package:istudy/services/auth.dart';

class StudentDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();

  // final String title;
  // StudentDrawer({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'iStudy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.speaker_notes),
          title: Text('My Notes'),
          onTap: () {
            Navigator.pushNamed(context, StudentHomeRoute);
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Sign out'),
          onTap: () async {
            await _authService.signOut();
          },
        ),
      ],
    ));
  }
}
