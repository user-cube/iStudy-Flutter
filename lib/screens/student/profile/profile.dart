import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istudy/app.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/services/auth.dart';
import 'package:istudy/widgets/loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _authService = AuthService();
  final FirebaseStorage storage = FirebaseStorage();
  StorageReference storageReference = FirebaseStorage.instance.ref();
  final Firestore _firestore = Firestore.instance;

  File _image;
  dynamic uid;
  var url;
  dynamic name = "";
  dynamic email = "";

  Future getUserImage() async {
    storageReference
        .child(uid)
        .getDownloadURL()
        .then((value) => setState(() => url = value));
  }

  Future getUserName() async {
    _firestore
        .collection('profile')
        .document(uid)
        .get()
        .then((value) => setState(() => name = value.data['name']));
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((res) {
      setState(() {
        uid = res.uid;
        email = res.email;
        getUserName();
        getUserImage();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print("Image path $_image");
      });
    }

    Future uploadPic(BuildContext context) async {
      StorageReference storageReference =
          FirebaseStorage.instance.ref().child(uid);
      StorageUploadTask storageUploadTask = storageReference.putFile(_image);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      setState(() {
        print("Profile picture uploaded.");
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile Picture Uploaded.'),
          ),
        );
        Navigator.pushNamed(context, ProfileRoute);
      });
    }

    print(url);
    print(name);
    return uid == null
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
            ),
            bottomNavigationBar: BottomNavigatorBar(4),
            drawer: StudentDrawer(),
            body: Builder(
              builder: (context) => Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Color(0xff476cfb),
                            child: ClipOval(
                              child: SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: (url != null)
                                    ? Image.network(
                                        url,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        "assets/images/logo.jpg",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 60.0,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 30.0,
                            ),
                            onPressed: () {
                              getImage();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            uploadPic(context);
                          },
                          elevation: 4.0,
                          color: Colors.green[200],
                          child: Text(
                            'Change picture',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.red[100],
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            await _authService.signOut();
                            Navigator.pushNamed(context, StudentHomeRoute);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
