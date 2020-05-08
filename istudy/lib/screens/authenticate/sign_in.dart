import 'package:flutter/material.dart';
import 'package:istudy/services/auth.dart';
import 'package:istudy/widgets/image_banner.dart';
import 'package:istudy/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toogleView;
  SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign in'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toogleView();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ImageBanner(assetPath: "assets/images/logo.jpg"),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: formDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty || !val.contains('@')
                      ? 'Enter an email'
                      : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: formDecoration.copyWith(hintText: 'Password'),
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.grey[100],
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _authService.signInEmailPassword(
                          email, password);
                      if (result == null) {
                        setState(
                            () => error = 'Please supply a valid combination.');
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// RaisedButton(
//           child: Text('sing in'),
//           onPressed: () async {
//             dynamic result = await _authService.signInAnon();
//             if (result == null) {
//               print('error signing in');
//             } else {
//               print('signed');
//               print(result.uid);
//             }
//           },
//         ),
