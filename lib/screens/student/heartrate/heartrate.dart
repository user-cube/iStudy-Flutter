import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istudy/drawers/student/bottomNavigation.dart';
import 'package:istudy/drawers/student/drawer.dart';
import 'package:istudy/services/heartrate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_android/android_hardware.dart'
    show Sensor, SensorEvent, SensorManager;

class HeartRateMonitor extends StatefulWidget {
  @override
  _HeartRateMonitorState createState() => _HeartRateMonitorState();
}

class _HeartRateMonitorState extends State<HeartRateMonitor>
    with TickerProviderStateMixin {
  Animation _heartAnimation;
  AnimationController _heartAnimationController;
  dynamic isRunning = true;
  dynamic heartResult = "Please hold calm...";
  FirebaseUser user;
  void checkPermissions() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sensors,
      Permission.storage,
    ].request();
    print(statuses[Permission.sensors]);
    user = await FirebaseAuth.instance.currentUser();
  }

  void heartRate() async {
    var sensor = await SensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);
    if (sensor != null && isRunning != false) {
      var events = await sensor.subscribe();
      events.listen((SensorEvent event) {
        if (event.values[0] != 0.0 && isRunning != false) {
          double value = event.values[0].roundToDouble();
          HeartRateService(uid: user.uid).addHeartRate(value);
          setState(() {
            isRunning = false;
            heartResult = "Heart Rate: " +
                value.toString() +
                " bpm" +
                "\nTo run another heart rate test\nhold your scanner again";
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _heartAnimation = Tween(begin: 150.0, end: 170.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.repeat();
      }
    });
    _heartAnimationController.forward();
    checkPermissions();
    heartRate();
  }

  @override
  void dispose() {
    super.dispose();
    _heartAnimationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Monitor'),
      ),
      bottomNavigationBar: BottomNavigatorBar(1),
      drawer: StudentDrawer(),
      body: Builder(
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _heartAnimationController,
                    builder: (context, child) {
                      return Center(
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: _heartAnimation.value,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(heartResult),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget secondChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          child: AnimatedBuilder(
            animation: _heartAnimationController,
            builder: (context, child) {
              return Center(
                child: Container(
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: _heartAnimation.value,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
