import 'package:cloud_firestore/cloud_firestore.dart';

class HeartRateService {
  final String uid;
  HeartRateService({this.uid});
  final CollectionReference heartRateReference =
      Firestore.instance.collection('heartrate');

  Future addHeartRate(double bpm) async {
    return await heartRateReference.document().setData({
      'uid': uid,
      'bpm': bpm,
      'timestamp': new DateTime.now().millisecondsSinceEpoch,
    });
  }
}
