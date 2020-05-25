import 'package:flutter/material.dart';
import 'package:istudy/drawers/teacher/bottomNavigationTeacher.dart';
import 'package:istudy/drawers/teacher/drawer.dart';

class AttendanceList extends StatefulWidget {
  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: TeacherDrawer(),
      bottomNavigationBar: BottomNavigatorBarTeacher(1),
      body: Text('Attendance List'),
    );
  }
}
