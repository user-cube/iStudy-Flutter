import 'package:flutter/material.dart';
import 'package:istudy/app.dart';

class BottomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (int index) {
        print(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, StudentHomeRoute);
            break;
          case 1:
            Navigator.pushNamed(context, AddNotesRoute);
            break;
          case 2:
            //
            break;
          default:
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.speaker_notes),
          title: Text('My Notes'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          title: Text('Add note'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        )
      ],
    );
  }
}
