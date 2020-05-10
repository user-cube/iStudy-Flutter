import 'package:flutter/material.dart';
import 'package:istudy/drawers/teacher/drawer.dart';

class TeacherHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: TeacherDrawer(),
    );
  }
}
