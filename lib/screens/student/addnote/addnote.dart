import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istudy/app.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/screens/student/addnote/uploader.dart';
import 'package:istudy/services/note.dart';
import 'package:istudy/shared/constants.dart';
import 'package:istudy/widgets/loading.dart';

class AddNote extends StatefulWidget {
  createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  /// Active image file
  File _imageFile;
  NotesService uploader = new NotesService();
  final _formKey = GlobalKey<FormState>();
  String uid;
  String subject = '';
  String notes = '';
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @protected
  @mustCallSuper
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    this.uid = user.uid.toString();
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = (await ImagePicker.pickImage(source: source));

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  List<Widget> buildChildren() {
    List<Widget> ret = [];
    if (_imageFile != null) {
      ret.add(Image.file(_imageFile));
      ret.add(Row(
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.refresh),
            onPressed: _clear,
          ),
        ],
      ));
      ret.add(Uploader(file: _imageFile));
      return ret;
    }
    ret.add(Row());
    return ret;
  }

  Widget _buildImageBoxes() {
    if (_imageFile != null) {
      return Row(
        children: <Widget>[
          Expanded(
            child: Image.file(_imageFile),
          ),
        ],
      );
    } else {
      return Row();
    }
  }

  Widget _buildButtonRow() {
    List<Widget> ret = [];
    ret.add(
      Expanded(
          child: IconButton(
        color: Colors.blue,
        icon: Icon(Icons.photo_camera),
        onPressed: () => _pickImage(ImageSource.camera),
      )),
    );
    ret.add(
      Expanded(
          child: IconButton(
        icon: Icon(Icons.photo_library),
        onPressed: () => _pickImage(ImageSource.gallery),
      )),
    );
    if (_imageFile != null) {
      ret.add(
        Expanded(
            child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => _clear(),
        )),
      );
    }
    return Row(children: ret);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading()
        : Scaffold(
          appBar: AppBar(
            title: Text('Add note'),
          ),
          bottomNavigationBar: BottomNavigatorBar(2),
          drawer: StudentDrawer(),
          body: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: ListView(
              children: <Widget>[
                this._buildImageBoxes(),
                this._buildButtonRow(),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: formDecoration.copyWith(hintText: 'Subject'),
                        validator: (val) => val.isEmpty ? 'Enter a subject' : null,
                        onChanged: (val) {
                          setState(() => subject = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        minLines: 2,
                        maxLines: 5,
                        decoration: formDecoration.copyWith(hintText: 'Notes'),
                        validator: (val) => val.isEmpty ? '' : null,
                        onChanged: (val) {
                          setState(() => notes = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.grey[100],
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            this.isLoading = true;
                          });
                          if (_formKey.currentState.validate()) {
                            String picName = DateTime.now().toString();
                            if (_imageFile != null) {
                              await this.uploader.startUpload(_imageFile,this.subject,this.notes,picName);
                            } else {
                              await this.uploader.save(this.subject, this.notes);
                            }
                            Navigator.pushNamed(context, StudentHomeRoute);
                            setState(() {
                              isLoading = false;
                            });
                          }

                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
  }
}
