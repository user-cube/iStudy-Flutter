import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:istudy/app.dart';
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
            leading: Icon(FontAwesomeIcons.qrcode),
            title: Text('QRCode Generator'),
            onTap: () {
              Navigator.pushNamed(context, TeacherHomeRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Attendance List'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () async {
              await _authService.signOut();
              Navigator.pushNamed(context, LoginRoute);
            },
          ),
        ],
      ),
    );
  }
}
