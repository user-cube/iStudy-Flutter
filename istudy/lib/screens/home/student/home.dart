import 'package:flutter/material.dart';
import 'package:istudy/services/auth.dart';
import 'package:istudy/widgets/drawer.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      title: 'My Notes',
    );
  }
}
