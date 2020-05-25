import 'package:flutter/material.dart';
import 'package:istudy/router.dart';
import 'package:istudy/screens/wrapper.dart';
import 'package:istudy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:istudy/models/user/user.dart';
import 'style.dart';

const StudentHomeRoute = "/";
const TeacherHomeRoute = "/teacher/";
const ProfileRoute = "/profile";
const NoteDetailRoute = "/note_detail";
const HeartRateMonitorRoute = "/heartrate";
const AddNotesRoute = "/notes/add";
const AttendanceRoute = "/attendance";
const TeacherProfileRoute = "/teacherprofile";
const AttendanceListRoute = "/attendancelist";
const LoginRoute = "/login";

class MyApp extends StatelessWidget {
  final Router _routes = Router();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: _routes.routes(),
        theme: _theme(),
        home: Wrapper(),
      ),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(headline6: AppBarTextStyle),
      ),
      textTheme: TextTheme(
          headline6: TitleTextStyle,
          bodyText2: Body1TextStyle,
          caption: CaptionTextStyle,
          subtitle2: SubTitleTextStyle),
    );
  }
}
