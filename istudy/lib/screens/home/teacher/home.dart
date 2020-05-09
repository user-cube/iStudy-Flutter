import 'package:flutter/material.dart';
import 'package:istudy/services/auth.dart';

class THome extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home T'),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'))
        ],
      ),
    );
  }
}
