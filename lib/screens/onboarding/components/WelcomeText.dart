import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  WelcomeText({this.text, this.size, this.weight});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Welcome",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          "Let's setup your account",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
