import 'package:flutter/material.dart';
import 'package:fyp/screens/onboarding/components/WelcomeText.dart';

class EmailStep extends StatelessWidget {
  final String email;
  const EmailStep({
    this.email,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        WelcomeText(),
        SizedBox(
          height: 40,
        ),
        Icon(
          Icons.mail_outline,
          size: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Please check your email",
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          email,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "for confirmation link",
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "Didn't receive a link?",
          style: TextStyle(
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "Resend",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
