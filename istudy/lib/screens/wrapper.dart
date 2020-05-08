import 'package:flutter/material.dart';
import 'package:istudy/models/user.dart';
import 'package:istudy/screens/authenticate/authenticate.dart';
import 'package:istudy/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return or authenticate widget
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
