import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istudy/app.dart';
import 'package:istudy/drawers/teacher/bottomNavigationTeacher.dart';
import 'package:istudy/drawers/teacher/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istudy/widgets/loading.dart';
import 'package:logger/logger.dart';
/**
 * for (var i in queryMap.values) {logger.d(i.documentID);}
 */

class AttendanceList extends StatefulWidget {
  @override
  _AttendanceListState createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  dynamic uid;
  dynamic email = "";
  bool isReady = false;
  final Firestore _firestore = Firestore.instance;
  Logger logger = new Logger();
  QuerySnapshot querySnapshot;
  Map queryMap;
  List modules = new List();

  @override
  initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
      setState(() {
        uid = res.uid;
        email = res.email;
        getInfo();
      });
    });
  }

  Future getInfo() async {
    _firestore
        .collection('attendance')
        .document(uid)
        .collection('modules')
        .getDocuments()
        .then((value) => setState(() {
              print(value);
              isReady = true;
              querySnapshot = value;
              queryMap = querySnapshot.documents.asMap();
              for (var i in queryMap.values) {
                modules.add(i.documentID);
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return (isReady == false)
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Attendance List'),
            ),
            drawer: TeacherDrawer(),
            bottomNavigationBar: BottomNavigatorBarTeacher(1),
            body: Container(
              padding: new EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: new ListView.builder(
                        itemCount: modules.length,
                        itemBuilder: (BuildContext context, int index) =>
                            _itemBuilder(context, index),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  _onLocationTap(BuildContext context, var module) {
    logger.d(module);
    Navigator.pushNamed(
      context,
      AttendanceListDetailRoute,
      arguments: {"id": module.toString()},
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final module = modules[index];
    var mod = module.toString().split('-');
    String name = mod[0];
    String data = mod[1] + '-' + mod[2] + '-' + mod[3];

    return GestureDetector(
      child: Container(
        child: Stack(
          children: [
            ListTile(
              title: Text('Module: ' + name),
              subtitle: Text('Date: ' + data),
            )
          ],
        ),
      ),
      onTap: () => _onLocationTap(context, module),
    );
  }
}
