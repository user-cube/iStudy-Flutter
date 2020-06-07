import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istudy/drawers/teacher/bottomNavigationTeacher.dart';
import 'package:istudy/drawers/teacher/drawer.dart';
import 'package:istudy/widgets/loading.dart';
import 'package:logger/logger.dart';

class AttendanceListDetail extends StatefulWidget {
  final String _listID;

  AttendanceListDetail(this._listID);

  @override
  _AttendanceListDetailState createState() =>
      _AttendanceListDetailState(_listID);
}

class _AttendanceListDetailState extends State<AttendanceListDetail> {
  final String _listID;
  _AttendanceListDetailState(this._listID);

  dynamic uid;
  dynamic email = "";
  bool isReady = false;
  final Firestore _firestore = Firestore.instance;
  StorageReference storageReference = FirebaseStorage.instance.ref();
  Logger logger = new Logger();
  QuerySnapshot querySnapshot;
  Map queryMap;
  List modules = new List();
  List emails = new List();
  List names = new List();
  List images = new List();

  @override
  void initState() {
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
        .document(_listID)
        .collection('students')
        .getDocuments()
        .then((value) => setState(() {
              querySnapshot = value;
              queryMap = querySnapshot.documents.asMap();
              for (var i in queryMap.values) {
                modules.add(i.documentID);
              }
              getEmails();
            }));
  }

  Future getEmails() async {
    for (var i in modules) {
      _firestore
          .collection('attendance')
          .document(uid)
          .collection('modules')
          .document(_listID)
          .collection('students')
          .document(i)
          .get()
          .then((value) => setState(() {
                emails.add(value.data['email']);
                names.add(value.data['name']);
              }));
    }
    getImages();
    isReady = true;
  }

  Future getImages() async {
    for (var i in modules) {
      try {
        storageReference.child(i).getDownloadURL().then((value) => setState(() {
              images.add(value);
            }));
      } on PlatformException catch (e) {
        print(e.toString());
      } on Exception catch (e) {
        print(e.toString());
      } catch (e) {
        print(e.toString());
      }
    }
    isReady = true;
  }

  @override
  Widget build(BuildContext context) {
    logger.e(isReady);
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

  Widget _itemBuilder(BuildContext context, int index) {
    if (emails.length > 0 && names.length > 0 && images.length > 0) {
      final email = emails[index];
      final name = names[index];
      final url = images[index];
      return Container(
        child: Stack(
          children: [
            ListTile(
              title: Text('Name: ' + name),
              subtitle: Text('Email: ' + email),
              leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Image.network(
                    url,
                    fit: BoxFit.fill,
                  )),
            )
          ],
        ),
      );
    } else {
      return Loading();
    }
  }
}
