import 'package:flutter/material.dart';
import 'package:share_goods/utils/Colors.dart';

Widget buildClipPath(BuildContext context) {
  return ClipPath(
    clipper: ClippingClass(),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.centerRight,
          stops: [0.1, 0.9],
          colors: [
            myGradientGreen1,
            myGradientGreen2,
          ],
        ),
      ),
    ),
  );
}

Widget buildOpacityClipPath(BuildContext context) {
  return Opacity(
    opacity: 0.75,
    child: ClipPath(
      clipper: ClippingClass(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.centerRight,
            stops: [0.1, 0.9],
            colors: [
              myGradientGreen1,
              myGradientGreen2,
            ],
          ),
        ),
      ),
    ),
  );
}
class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(
      0,
      size.height / 1.75,
    ); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.2, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

    var secondStart = Offset(
      size.width - (size.width / 3.5),
      size.height - 105,
    );
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height / 1.4);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
      secondStart.dx,
      secondStart.dy,
      secondEnd.dx,
      secondEnd.dy,
    );

    path.lineTo(
      size.width,
      0,
    ); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
    // TODO: implement shouldReclip
  }
}
