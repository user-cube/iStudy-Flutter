import 'package:flutter/material.dart';
import 'package:istudy/screens/wrapper.dart';
import 'package:istudy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:istudy/models/user.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
