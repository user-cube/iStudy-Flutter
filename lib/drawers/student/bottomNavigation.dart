import 'package:flutter/material.dart';
import 'package:istudy/app.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigatorBar extends StatefulWidget {
  final int myIndex;
  BottomNavigatorBar(this.myIndex);
  @override
  _BottomNavigatorBarState createState() => _BottomNavigatorBarState(myIndex);
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  final int myIndex;
  _BottomNavigatorBarState(this.myIndex);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: myIndex,
      onTap: (int index) {
        print(index);
        switch (index) {
          case 0:
            //setState(() => myIndex = 0);
            Navigator.pushNamed(context, StudentHomeRoute);
            break;
          case 1:
            //setState(() => myIndex = 1);
            Navigator.pushNamed(context, HeartRateMonitorRoute);
            break;
          case 2:
            //setState(() => myIndex = 2);
            Navigator.pushNamed(context, AddNotesRoute);
            break;
          case 3:
            //setState(() => myIndex = 3);
            break;
          default:
            //setState(() => myIndex = null);
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker_notes),
          title: Text('My Notes'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          title: Text('Heart Rate'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          title: Text('Add note'),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.qrcode),
          title: Text('Attendance'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
    );
  }
}
