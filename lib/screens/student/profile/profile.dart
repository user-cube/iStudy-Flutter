import 'package:flutter/material.dart';
import 'package:istudy/app.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      bottomNavigationBar: BottomNavigatorBar(4),
      drawer: StudentDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/logo.jpg"),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Text('Rui Coelho'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Text("ruicoelho@ua.pt"),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: Colors.blue[100],
            child: Text(
              'Update profile',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () async {},
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: Colors.red[100],
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushNamed(context, StudentHomeRoute);
            },
          ),
        ],
      ),
    );
  }
}
