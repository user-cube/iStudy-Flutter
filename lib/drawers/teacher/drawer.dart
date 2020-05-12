import 'package:flutter/material.dart';
import 'package:istudy/services/auth.dart';

class TeacherDrawer extends StatelessWidget {
  final AuthService _authService = AuthService();

  // final String title;
  // TeacherDrawer({Key key, this.title}) : super(key: key);
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
              'iStudy - Teacher',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
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
      ),
    );
  }
}
