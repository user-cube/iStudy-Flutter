import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istudy/models/user/user.dart';
import 'package:istudy/screens/authenticate/authenticate.dart';
import 'package:istudy/screens/student/home/home.dart';
import 'package:istudy/screens/teacher/home/home.dart';
import 'package:istudy/widgets/loading.dart';
import 'package:logger/logger.dart';
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
  Logger _logger = new Logger();
  bool loading = false;
  final Firestore _firestore = Firestore.instance;
  dynamic role;

  Future checkRole(String uid) async {
    await _firestore
        .collection('profile')
        .document(uid)
        .get()
        .then((value) => setState(() => role = value.data['role']));
  }

  @override
  void initState() {
    super.initState();
    try {
      final user = Provider.of<User>(context);
      if (user != null) checkRole(user.uid);
    } catch (e) {
      _logger.d(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      checkRole(user.uid);
      if (role == 1) {
        setState(() {
          loading = false;
          role = null;
        });
        return TeacherHome();
      }
      if (role == 0) {
        setState(() {
          loading = false;
          role = null;
        });
        return StudentHome();
      }
      setState(() => loading = true);
      return Loading();
    }
  }
}
