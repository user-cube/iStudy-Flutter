import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shortid/shortid.dart';

class NotesService {

  final FirebaseStorage _storage = FirebaseStorage(
      storageBucket: 'gs://istudy-63238.appspot.com');

  final CollectionReference firestore = Firestore.instance.collection('notes');

  Future save(String subject, String note) async {
    return await firestore.document().setData({
      'id': shortid.generate(),
      'subject': subject,
      'note': note,
      'picture': null
    });
  }

  /// Starts an upload task
  Future<void> startUpload(File file, String subject, String note, String picName) async {
    /// Unique file name for the file
    String filePath = 'images/$picName.png';
    StorageTaskSnapshot snapshot = await _storage.ref().child(filePath).putFile(file).onComplete;
    if (snapshot.error == null){
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await firestore.document().setData({
        'id': shortid.generate(),
        'subject': subject,
        'note': note,
        'picture': downloadUrl
      });
    }
  }

  Future<QuerySnapshot> fetchAll() {
    return firestore.getDocuments();
  }

  Future<QuerySnapshot> fetchById(String id){
    return firestore.where("id == $id").getDocuments();
  }
}