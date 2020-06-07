import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;
  dynamic uid;
  dynamic email = "";
  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
    FirebaseAuth.instance.currentUser().then((res) {
      setState(() {
        uid = res.uid;
        email = res.email;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      drawer: StudentDrawer(),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigatorBar(3),
      body: Builder(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextField(
                      controller: this._outputController,
                      readOnly: true,
                      maxLines: 2,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.wrap_text),
                        helperText: '',
                        hintText: 'Display Text from QRCode',
                        hintStyle: TextStyle(fontSize: 15),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                      ),
                    ),
                    SizedBox(height: 20),
                    this._buttonGroup(),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/scanner.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    final CollectionReference attendanceReference =
        Firestore.instance.collection('attendance');
    var contentSplited = barcode.split("-");
    String module = contentSplited[0];
    String data =
        contentSplited[1] + "-" + contentSplited[2] + "-" + contentSplited[3];
    String teacherID = contentSplited[4];

    if (contentSplited.length == 5) {
      attendanceReference
          .document(teacherID)
          .collection('modules')
          .document(module + "-" + data)
          .collection('students')
          .document(uid)
          .setData({'state': 'present', 'email': email});
      this._outputController.text = barcode;
    }
  }
}
