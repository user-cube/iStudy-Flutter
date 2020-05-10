import 'package:flutter/material.dart';
import 'package:istudy/screens/home/teacher/home.dart';
import 'package:istudy/screens/wrapper.dart';
import 'package:istudy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:istudy/models/user.dart';
import 'package:istudy/screens/home/student/home.dart';

const SHome = "/";
const THome = "/teacher/";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: _routes(),
        home: Wrapper(),
      ),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case SHome:
          screen = StudentHome();
          break;
        case THome:
          screen = TeacherHome();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
