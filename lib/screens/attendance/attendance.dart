import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      bottomNavigationBar: BottomNavigatorBar(3),
      drawer: StudentDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            child: Text("Attendance"),
          ),
        ],
      ),
    );
  }
}
