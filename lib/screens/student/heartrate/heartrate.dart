import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/services/heartrate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_android/android_hardware.dart'
    show Sensor, SensorEvent, SensorManager;

class HeartRateMonitor extends StatefulWidget {
  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

dynamic heartrate;

class _HeartRateMonitorState extends State<HeartRateMonitor> {
  PermissionStatus _status;

  void checkPermissions() async {
    if (await Permission.sensors.request().isGranted) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      var sensor = await SensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);
      if (sensor != null) {
        var events = await sensor.subscribe();
        events.listen((SensorEvent event) {
          print(event.values[0]);
          if (event.values[0] != 0.0) {
            HeartRateService(uid: user.uid).addHeartRate(event.values[0]);
          }
        });
      }
    }
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sensors,
      Permission.storage,
    ].request();
    print(statuses[Permission.sensors]);
  }

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Monitor'),
      ),
      drawer: StudentDrawer(),
      body: SafeArea(
        child: Text('Heart Rate'),
      ),
    );
  }
}
