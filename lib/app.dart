import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:istudy/screens/student/heartrate/heartrate.dart';
import 'package:istudy/screens/teacher/home/home.dart';
import 'package:istudy/screens/wrapper.dart';
import 'package:istudy/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:istudy/models/user/user.dart';
import 'package:istudy/screens/student/home/home.dart';
import 'style.dart';
import 'package:istudy/screens/student/note_detail/note_detail.dart';
import 'package:istudy/screens/student/addnote/addnote.dart';

const StudentHomeRoute = "/";
const TeacherHomeRoute = "/teacher/";
const ProfileRoute = "/profile";
const NoteDetailRoute = "/note_detail";
const HeartRateMonitorRoute = "/heartrate";
const AddNotesRoute = "/notes/add";

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({
    Key key,
    @required this.camera,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: _routes(),
        theme: _theme(),
        home: Wrapper(),
      ),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case StudentHomeRoute:
          screen = StudentHome();
          break;
        case TeacherHomeRoute:
          screen = TeacherHome();
          break;
        case NoteDetailRoute:
          screen = NoteDetail(arguments['id']);
          break;
        case HeartRateMonitorRoute:
          screen = HeartRateMonitor();
          break;
        case ProfileRoute:
          break;
        case AddNotesRoute:
          screen = AddNote(camera: this.camera);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
        appBarTheme: AppBarTheme(textTheme: TextTheme(title: AppBarTextStyle)),
        textTheme: TextTheme(
            title: TitleTextStyle,
            body1: Body1TextStyle,
            caption: CaptionTextStyle,
            subtitle: SubTitleTextStyle));
  }
}
