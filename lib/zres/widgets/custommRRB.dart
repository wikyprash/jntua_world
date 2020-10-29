import 'package:flutter/material.dart';

class CustomRRB extends StatelessWidget {
  CustomRRB({
    @required this.onPressed,
    this.padding,
    this.txt = 'click',
    this.radius = 0.0,
  });

  final String txt;
  final GestureTapCallback onPressed;
  final double radius;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        // color: materialBlue,
        child: Text(
          txt,
          style: TextStyle(
            // color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
