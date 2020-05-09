import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final String uid;
  ProfileService({this.uid});
  final CollectionReference profileReference =
      Firestore.instance.collection('profile');

  Future updateUserProfile(String name, int role) async {
    return await profileReference.document(uid).setData({
      'name': name,
      'role': role,
    });
  }
}
