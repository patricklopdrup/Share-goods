import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_goods/screens/auth/forgot_password_screen.dart';
import 'package:share_goods/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:share_goods/utils/Colors.dart';

class SignIn extends StatefulWidget {
  final Function togglePage;
  SignIn({this.togglePage});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // instance of AuthService class auth from services/auth.dart
  final AuthService _auth = AuthService();

  // key used for making clickable TextSpan
  final GlobalKey _textKey = new GlobalKey();
  final _formKey = GlobalKey<FormState>();

  // text field variables
  String email = '';
  String password = '';
  String error = '';
  bool checkS = false;
  // text styles
  TextStyle defaultStyle = TextStyle(color: Colors.white, fontSize: 10.0);
  TextStyle linkStyle = TextStyle(color: myLightGreen, fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6, 0.9],
            colors: [
              myGradientGreen0,
              myGradientGreen1,
              myGradientGreen2,
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                checkS = false;
                error = '';
              },
              child: Stack(children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: checkS
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 100.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Velkommen til ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'ShareGoods',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30.0),
                          _buildEmailTextField(),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildPasswordTextField(),
                          _buildForgotPassword(),
                          SizedBox(height: 5.0),
                          Text(
                            error,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: 'OpenSans'),
                          ),
                          _buildLoginButton(),
                          _buildRegisterButton(),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            )));
  }

  Widget _buildEmailTextField() {
    final node = FocusScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mail',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
              color: myGradientGreen1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 3),
                )
              ]),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'Indtast din mail',
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: 'OpenSans')),
              onTap: () {
                checkS = true;
              },
              validator: (val) =>
                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)
                      ? ''
                      : null,
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              }),
        )
      ],
    );
  }

  Widget _buildPasswordTextField() {
    final node = FocusScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Kodeord',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.white),
              color: myGradientGreen1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, 5),
                )
              ]),
          child: TextFormField(
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => node.unfocus(),
              keyboardType: TextInputType.text,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: 'Indtast kodeord',
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: 'OpenSans')),
              onTap: () {
                checkS = true;
              },
              validator: (val) => val.length < 6 ? '' : null,
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              }),
        )
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPW()),
            );
            print('Forgot pw Button Pressed');
          },
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            'Glemt kodeord?',
            style: TextStyle(
                color: Colors.white, fontFamily: 'OpenSans', fontSize: 12.0),
          ),
        ));
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: ButtonTheme(
        minWidth: double.maxFinite,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: RaisedButton(
            color: Colors.white,
            highlightColor: myLightBlue4,
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            child: Text(
              'LOGIN',
              style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 4.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                dynamic result =
                    await _auth.signInMail(email.trim(), password.trim());
                print('Result is' + result);
                if (result == null) {
                  print('Result was null');
                  setState(() => error = 'Enter valid email or password');
                }
                print('Email is:' + email);
                print('Password is' + password);
              } else {
                setState(() => error = 'Enter valid email or password');
              }
            }),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return RichText(
        key: _textKey,
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: 'No account? ',
              style: defaultStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Clicked No Account');
                }),
          TextSpan(
            text: 'Register',
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.togglePage();
                print('Clicked Register');
              },
          )
        ]));
  }
}
