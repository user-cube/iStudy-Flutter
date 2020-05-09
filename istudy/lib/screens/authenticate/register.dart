import 'package:flutter/material.dart';
import 'package:istudy/screens/home/teacher/home.dart';
import 'package:istudy/services/auth.dart';
import 'package:istudy/widgets/image_banner.dart';
import 'package:istudy/shared/constants.dart';
import 'package:istudy/widgets/loading.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  Register({this.toogleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  String name = '';
  int role = 0;
  int _radioValue1 = 0;
  void _handleRadioValueChange1(int value) {
    setState(() {
      switch (value) {
        case 0:
          role = 0;
          break;
        case 1:
          role = 1;
          break;
        default:
          role = role;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text('Sign up'),
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
                      'Sign In',
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
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: formDecoration.copyWith(hintText: 'Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your name' : null,
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
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
                        decoration:
                            formDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _radioValue1,
                            activeColor: Colors.green,
                            onChanged: (val) {
                              setState(
                                () {
                                  role = 0;
                                  _radioValue1 = 0;
                                },
                              );
                            },
                          ),
                          Text('Student'),
                          Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            activeColor: Colors.green,
                            onChanged: (val) {
                              setState(
                                () {
                                  role = 1;
                                  _radioValue1 = 1;
                                },
                              );
                            },
                          ),
                          Text('Teacher'),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.grey[100],
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _authService.signUp(
                                email, password, name, role);
                            if (result == null) {
                              setState(
                                () {
                                  error = 'Please supply a valid combination.';
                                  loading = false;
                                },
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
