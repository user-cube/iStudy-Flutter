import 'package:flutter/material.dart';
import 'package:istudy/screens/attendance/attendance.dart';
import 'package:istudy/screens/authenticate/sign_in.dart';
import 'package:istudy/screens/student/heartrate/heartrate.dart';
import 'package:istudy/screens/student/home/home.dart';
import 'package:istudy/screens/student/note_detail/note_detail.dart';
import 'package:istudy/screens/student/profile/profile.dart';
import 'package:istudy/screens/teacher/attendance/attendanceList.dart';
import 'package:istudy/screens/teacher/home/home.dart';
import 'package:istudy/screens/teacher/profile/profile.dart';
import 'package:istudy/screens/wrapper.dart';

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

class Router {
  RouteFactory routes() {
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
          screen = Profile();
          break;
        case AttendanceRoute:
          screen = Attendance();
          break;
        case AttendanceListRoute:
          screen = AttendanceList();
          break;
        case TeacherProfileRoute:
          screen = ProfileTeacher();
          break;
        case LoginRoute:
          screen = Wrapper();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
