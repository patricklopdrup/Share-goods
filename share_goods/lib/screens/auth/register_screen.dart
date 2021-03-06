import 'package:flutter/material.dart';
import 'package:share_goods/bottom_navigator.dart';
import 'package:share_goods/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:share_goods/utils/Colors.dart';

class Register extends StatefulWidget {
  final Function togglePage;

  Register({this.togglePage});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text field variables
  String name = '';
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
                            'Tilmeld dig',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
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
                          _buildUsernameTextField(),
                          SizedBox(height: 30.0),
                          _buildEmailTextField(),
                          SizedBox(
                            height: 30.0,
                          ),
                          _buildPasswordTextField(),
                          SizedBox(height: 5.0),
                          Text(
                            error,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontFamily: 'OpenSans'),
                          ),
                          _buildRegisterButton(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    title: Align(
                      alignment: Alignment(-1.25, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Log ind',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ), // You can add title here
                    ),
                    leading: new IconButton(
                      icon: new Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: myGradientGreen2
                        .withOpacity(0.4), //You can make this transparent
                    elevation: 0.0, //No shadow
                  ),
                ),
              ]),
            )));
  }


  Widget _buildUsernameTextField() {
    final node = FocusScope.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Navn',
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
                  offset: Offset(0, 5),
                )
              ]),
          child: TextFormField(
              textInputAction: TextInputAction.next,
              onEditingComplete: () => node.nextFocus(),
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  hintText: 'Indtast navn',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                  )),
              onTap: () {
                checkS = true;
              },
              // validator: (val) => !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? '' : null,
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              }),
        )
      ],
    );
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
                  hintText: 'Indtast mail',
                  hintStyle:
                  TextStyle(color: Colors.white, fontFamily: 'OpenSans')),
              onTap: () {
                checkS = true;
              },
              validator: (val) =>
              !RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val)
                  ? ''
                  : null,
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              }),
        ),
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
              onFieldSubmitted: (_) => registerUser(),
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

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: ButtonTheme(
        minWidth: double.maxFinite,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: RaisedButton(
            color: Colors.white,
            elevation: 5.0,
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Tilmeld',
              style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 4.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
            onPressed: () async {
              registerUser();
            }),
      ),
    );
  }

  void registerUser() async {
    // check the form for empty spots and validity

    if (_formKey.currentState.validate()) {
      print(email);
      print(password);
      try {
        dynamic result = await _auth.registerWithEmailAndPassword(
          name.trim(),
          email.trim(),
          password.trim(),
        );
        print('Result is ' + result.uid);
        if (result == null) {
          print('Result was null');
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigator()), (route) => false);
        }
      } catch (e) {
        switch (e) {
          case 'email-already-in-use':
            {
              setState(() => error = 'Mail er allerede brugt');
            }
            break;

          default:
            {
              print('Error with registering: ' + e);
            }
            break;
        }
      }
    } else {
      setState(() => error = 'Udfyld alle felter');
    }
  }
}
