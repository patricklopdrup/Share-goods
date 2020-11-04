import 'package:flutter/material.dart';
import 'package:share_goods/services/auth.dart';

import '../../myAppBar.dart';
import '../../myColors.dart';


class Register extends StatefulWidget {
  final Function togglePage;
  Register({this.togglePage});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // text field variables
  String email = '';
  String password = '';
  String error = '';

  // instance of AuthService class auth from services/auth.dart
  final AuthService _auth = AuthService();
  //
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Register',
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 75.0),
          child: Form(
            key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 8.0,
                          ),
                        hintText: 'Email'
                      ),
                    validator: (val) => !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? 'Enter valid email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }
                  ),

                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 8.0,
                      ),
                      hintText: 'Password'
                    ),
                      validator: (val) => val.length < 6 ? 'Password must be atleast 6 chars long' : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      }
                  ),

                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: myLightGreen,
                      child: Text('Register',
                      style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        // check the form for empty spots and validity

                        if (_formKey.currentState.validate()) {
                          print(email);
                          print(password);

                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email.trim(), password.trim());
                          print('Result is' + result);
                          if (result = null) {
                            print('Result was null');
                          }
                        }else{
                          setState(() => error = 'Enter valid input');
                        }
                      }
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.0
                    )
                  )
                ],
              )
          )
      ),
    );
  }
}
