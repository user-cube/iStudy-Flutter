import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istudy/models/user.dart';
import 'package:istudy/screens/authenticate/authenticate.dart';
import 'package:istudy/screens/home/student/home.dart';
import 'package:istudy/screens/home/teacher/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return or authenticate widget
    return HandleAuhtentication();
  }
}

class HandleAuhtentication extends StatefulWidget {
  @override
  _HandleAuhtenticationState createState() => _HandleAuhtenticationState();
}

class _HandleAuhtenticationState extends State<HandleAuhtentication> {
  final Firestore _firestore = Firestore.instance;
  dynamic role;
  Future checkRole(String uid) async {
    _firestore
        .collection('profile')
        .document(uid)
        .get()
        .then((value) => role = value.data['role']);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      checkRole(user.uid);
      if (role == 1) {
        return THome();
      }
      return Home();
    }
  }
}
