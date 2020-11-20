import 'package:flutter/material.dart';
import 'package:share_goods/services/auth.dart';

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
  bool checkS = false;

  // instance of AuthService class auth from services/auth.dart
  final AuthService _auth = AuthService();
  //
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6, 0.9],
            colors: [
              myLightBlue1,
              myLightBlue2,
              myLightBlue3,
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
              checkS = false;
              error = '';
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: checkS ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 100.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Register to',style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 20.0, fontWeight: FontWeight.normal),),
                          Text('ShareGoods', style: TextStyle(color: Colors.white, fontFamily: 'OpenSans', fontSize: 30.0, fontWeight: FontWeight.bold),),
                          SizedBox(height: 30.0),
                          _buildUsernameTextField(),
                          SizedBox(height: 30.0),
                          _buildEmailTextField(),
                          SizedBox(height: 30.0,),
                          _buildPasswordTextField(),
                          SizedBox(height: 5.0),
                          Text(error, style: TextStyle(color: Colors.red, fontSize: 12, fontFamily: 'OpenSans'),),
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
    );
  }

  Widget _buildUsernameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(
        'Name',
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
            color: myLightBlue2,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0,5),
              )
            ]
        ),
        child: TextFormField(
            keyboardType: TextInputType.name,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                errorStyle: TextStyle(height: 0) ,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 15),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                hintText: 'Enter your Name',
                hintStyle: TextStyle(color: Colors.white, fontFamily: 'OpenSans',)
            ),
            onTap: (){
              checkS = true;
            },
            validator: (val) => !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? '' : null,
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

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(
        'Email',
        style: TextStyle(color: Colors.white),
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
            color: myLightBlue2,
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
                errorStyle: TextStyle(height: 0) ,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 15),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: 'Enter your E-mail',
                hintStyle: TextStyle(color: Colors.white, fontFamily: 'OpenSans')
            ),
            onTap: (){
              checkS = true;
            },
            validator: (val) => !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? '' : null,
            onChanged: (val) {
              setState(() {
                email = val;
              });
            }
        ),
       ),
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
            border: Border.all(color: Colors.white),
            color: myLightBlue2,
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
                errorStyle: TextStyle(height: 0),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 15),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter your Password',
                hintStyle: TextStyle(color: Colors.white, fontFamily: 'OpenSans')
            ),
            onTap: (){
              checkS = true;
            },
            validator: (val) => val.length < 6 ? '' : null,
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

  Widget _buildRegisterButton() {
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
              'REGISTER',
              style: TextStyle(color: Color(0xFF527DAA), letterSpacing: 4.0, fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'OpenSans' ),
            ),
            onPressed: () async {
             registerUser();
            }
        ),
      ),
    );
  }
  void registerUser() async {
    // check the form for empty spots and validity

    if (_formKey.currentState.validate()) {
      print(email);
      print(password);
      try {
        dynamic result = await _auth
            .registerWithEmailAndPassword(
            email.trim(), password.trim());
        print('Result is' + result.uid);
        if (result == null) {
          print('Result was null');
        }
      } catch (e) {
        switch(e) {
          case 'email-already-in-use': {
            setState(() => error = 'Entered email is already in use!');
          }
          break;

          default: {
            print('Error with registering: ' + e);
          }
          break;
        }
      }
    }else{
      setState(() => error = 'Enter valid input');
    }
  }
}
