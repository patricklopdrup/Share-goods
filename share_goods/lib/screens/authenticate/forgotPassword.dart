import 'package:flutter/material.dart';
import '../../myColors.dart';

class ForgotPW extends StatefulWidget {
  @override
  _ForgotPWState createState() => _ForgotPWState();
}

class _ForgotPWState extends State<ForgotPW> {
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

    );
  }
}
