import 'package:flutter/material.dart';
import 'package:istudy/app.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigatorBarTeacher extends StatefulWidget {
  final int myIndex;
  BottomNavigatorBarTeacher(this.myIndex);
  @override
  _BottomNavigatorBarTeacherState createState() =>
      _BottomNavigatorBarTeacherState(myIndex);
}

class _BottomNavigatorBarTeacherState extends State<BottomNavigatorBarTeacher> {
  final int myIndex;
  _BottomNavigatorBarTeacherState(this.myIndex);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: myIndex,
      onTap: (int index) {
        print(index);
        switch (index) {
          case 0:
            //setState(() => myIndex = 0);
            Navigator.pushNamed(context, TeacherHomeRoute);
            break;
          case 1:
            //setState(() => myIndex = 1);
            Navigator.pushNamed(context, HeartRateMonitorRoute);
            break;
          default:
            //setState(() => myIndex = null);
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.qrcode),
          title: Text('Generate QR'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Attendance List'),
        ),
      ],
    );
  }
}
