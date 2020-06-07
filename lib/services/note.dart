import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NotesService {
  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://istudy-63238.appspot.com');

  final CollectionReference firestore = Firestore.instance.collection('notes');

  Future save(String subject, String note, String picName) async {
    return await firestore.document().setData({
      'subject': subject,
      'note': note,
      'picture': picName
    });
  }

  /// Starts an upload task
  void startUpload(File file) {
    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';
    _storage.ref().child(filePath).putFile(file);
  }
}