import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:share_goods/myColors.dart';
import 'package:share_goods/myAppBar.dart';
import 'package:share_goods/screens/authenticate/register.dart';
import 'package:share_goods/screens/home/home.dart';
import 'package:share_goods/services/auth.dart';
import 'package:flutter/gestures.dart';



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
  String email ='';
  String password = '';
  String error = '';

  // text styles
  TextStyle defaultStyle = TextStyle(color: Colors.white, fontSize: 10.0);
  TextStyle linkStyle = TextStyle(color: myLightGreen, fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    myGradientGreen0,
                    myGradientGreen1,
                    myDarkGreen,
                  ],
                  stops: [0.1, 0.6, 0.9],
                )
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Welcome to',style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0, fontWeight: FontWeight.normal),),
                      Text('ShareGoods', style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 30.0, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30.0),
                      _buildEmailTextField(),
                      SizedBox(height: 30.0,),
                      _buildPasswordTextField(),
                      _buildForgotPassword(),
                      _buildLoginButton(),
                      _buildRegisterButton(),
                    ],
                  ),
                ),
              ),
            )
          ]

        ),
      )
    )
    ;
  }

  Widget _buildEmailTextField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(
        'Email',
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: myGradientGreen1,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0,3),
              )
            ]
        ),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your E-mail',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'OpenSans')
          ),
            validator: (val) => !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? 'Enter valid email' : null,
            onChanged: (val) {
              setState(() {
                email = val;
              });
            }
        ),
      )
    ],
    );
  }

  Widget _buildPasswordTextField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text(
        'Password',
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: myGradientGreen1,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0,5),
              )
            ]
        ),
        child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'OpenSans')
          ),
            validator: (val) => val.length < 6 ? 'Password must be atleast 6 chars long' : null,
            onChanged: (val) {
              setState(() {
                password = val;
              });
            }
        ),
      )
    ],
    );
  }

  Widget _buildForgotPassword() {
    return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          onPressed: () => print('Forgot pw Button Pressed'),
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 12.0),
          ),
        )
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: ButtonTheme(
        minWidth: double.maxFinite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
        ),
        child: RaisedButton(
            color: Colors.white,
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            child: Text(
              'LOGIN',
              style: TextStyle(color: Color(0xFF527DAA), letterSpacing: 1.5, fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'OpenSans' ),
            ),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                dynamic result = await _auth.signInMail(email.trim(),
                    password.trim());
                print('Result is' + result);
                if (result == null) {
                  print('Result was null');
                } else {
                  setState(() => error = 'Enter valid input');
                }
                print('Email is:' + email);
                print('Password is' + password);
              }
            }
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return RichText(
        key: _textKey,
        text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'No account? ',
                  style: defaultStyle,
                  recognizer: TapGestureRecognizer()..onTap = (){
                    print('Clicked Sign in');
                  }
              ),
              TextSpan(
                text: 'Register',
                style: linkStyle,
                recognizer: TapGestureRecognizer()..onTap = () {
                  widget.togglePage();
                  print('Clicked Register');
                  //setState(() {
                  //widget.togglePage();
                  //});
                },
              )
            ]
        ));
  }

}
