import 'package:flutter/material.dart';
import 'SignForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  static String routeName = '/loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 10),
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                Text(
                  "සෞඛ්‍ය ප්‍රවර්ධන කාර්යාංශය",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "சுகாதார மேம்பாட்டுப் பணியகம்",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "Health Promotion Bureau",
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // Text(
                //   "Vaccine Management System",
                //   style: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
                SignForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
