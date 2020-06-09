import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shortid/shortid.dart';

class NotesService {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://istudy-63238.appspot.com');

  final CollectionReference firestore = Firestore.instance.collection('notes');

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user.uid.toString();
  }

  Future save(String subject, String note) async {
    var uid = await getCurrentUser();
    return await firestore.document(uid).setData({
      'id': shortid.generate(),
      'subject': subject,
      'note': note,
      'picture': null
    });
  }

  /// Starts an upload task
  Future<void> startUpload(
      File file, String subject, String note, String picName) async {
    /// Unique file name for the file
    var uid = await getCurrentUser();
    String filePath = 'images/$picName.png';
    StorageTaskSnapshot snapshot =
        await _storage.ref().child(filePath).putFile(file).onComplete;
    if (snapshot.error == null) {
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await firestore.document(uid).collection('notes').document().setData({
        'id': shortid.generate(),
        'subject': subject,
        'note': note,
        'picture': downloadUrl
      });
    }
  }

  Future<QuerySnapshot> fetchAll() async {
    var uid = await getCurrentUser();
    return firestore.document(uid).collection('notes').getDocuments();
  }

  Future<QuerySnapshot> fetchById(String id) async {
    var uid = await getCurrentUser();
    return firestore
        .document(uid)
        .collection('notes')
        .where('id', isEqualTo: id)
        .getDocuments();
  }
}
