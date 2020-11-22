import 'package:flutter/material.dart';
import 'package:jntua_world/zres/colors.dart';

class CustomRRB extends StatelessWidget {
  CustomRRB({@required this.onPressed, this.txt = 'click', this.radius = 30.0});

  final String txt;
  final GestureTapCallback onPressed;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 25, 30, 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        color: mBtn,
        child: Text(
          txt,
          style: TextStyle(
            color: Colors.white,
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