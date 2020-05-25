import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:istudy/screens/student/addnote/uploader.dart';

class AddNote extends StatefulWidget {
  createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  /// Active image file
  File _imageFile;
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

  List<Widget> buildChildren(){
    List<Widget> ret = [];
    if (_imageFile != null){
      ret.add(Image.file(_imageFile));
      ret.add(
        Row(children: <Widget>[
          FlatButton(
            child: Icon(Icons.refresh),
            onPressed: _clear,
          ),
        ],
        )
      );
      ret.add(Uploader(file: _imageFile));
      return ret;
    }
    ret.add(Row());
    return ret;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
              Expanded(child:
              IconButton(
                color: Colors.blue,
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera),
              )),
              Expanded(child:
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
              )),
            ],
          ),
      ),
      body: ListView(
        children: this.buildChildren()
      ),
    );
  }
}