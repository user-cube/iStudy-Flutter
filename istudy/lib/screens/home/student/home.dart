import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/drawer.dart';

class StudentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StudentDrawer(
      title: 'My Notes',
    );
  }
}
