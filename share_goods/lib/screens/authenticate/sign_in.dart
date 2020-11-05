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
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 9.0);
  TextStyle linkStyle = TextStyle(color: myLightGreen, fontSize: 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Sign in',
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
                  setState(() {
                    email = val;
                  });
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
                    setState(() {
                      password = val;
                    });
                  }
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                  minWidth: 100.0,
                  height: 40.0,
                  child: RaisedButton(
                      color: myLightGreen,
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white, ),
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
              ),

              SizedBox(height: 12.0),
              Text(
                  error,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.0
                  )
              ),

              RichText(
                key: _textKey,
                text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign in or choose to ',
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
              ))
             ],
          )
        )
      ),
    );
  }
}
