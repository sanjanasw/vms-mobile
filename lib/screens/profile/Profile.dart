import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:fyp/components/MainAppBar.dart';
import 'package:fyp/components/DefaultButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:fyp/screens/profile/components/YourAccountDetails.dart';

import '../login/Login.dart';

class Profile extends StatelessWidget {
  static String routeName = '/profileScreen';

  TextEditingController _password = TextEditingController();
  TextEditingController _currentPassword = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool checkColor = false;
  updatePassword(BuildContext context) async {
    var url = Uri.parse(kApiUrl + '/auth/change-password');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    Map data = {
      "currentPassword": _currentPassword.text,
      "newPassword": _confirmPassword.text,
    };
    var body = json.encode(data);
    print(url);
    print(data);
    var jsonResponse;
    try {
      var res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);
      print(res.statusCode);

      if (res.statusCode == 400) {
        print(json.decode(res.body));
      }
      if (res.statusCode == 200) {
        jsonResponse = json.decode(res.body);
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Password Successfully Updated");
        _confirmPassword.clear();
        _password.clear();
        _currentPassword.clear();
        print("Response Status: ${res.statusCode}");

        if (jsonResponse != null) {}
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: SafeArea(
          child: MainAppBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Your Account Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                thickness: 1.2,
                color: Color.fromRGBO(132, 135, 142, 1),
              ),
              SizedBox(
                height: 15,
              ),
              YourAccountDetails(),
              SizedBox(
                height: 17,
              ),
              Text(
                "Your Login Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(
                thickness: 1.2,
                color: Color.fromRGBO(132, 135, 142, 1),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      obscureText: true,
                      controller: _currentPassword,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 15,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: "Enter your current password",
                        labelText: "Current Password",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Current password can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _password,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 15,
                        ),
                        hintText: "Enter your new password",
                        labelText: "New Password",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "New password can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _confirmPassword,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(
                          fontSize: 15,
                        ),
                        hintText: "Confirm your new password",
                        labelText: "Confirm Password",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Confirm password can't be empty";
                        }
                        if (_password.text != _confirmPassword.text) {
                          return "Confirm password doesn't match ";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      press: () {
                        if (_formKey.currentState.validate()) {
                          // _currentPassword.clear();
                          // _confirmPassword.clear();
                          // _password.clear();
                          updatePassword(context);

                          print("successful");
                          return;
                        } else {
                          print("unsuccessful");
                        }
                      },
                      text: "Update Password",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                press: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (context) => new LoginScreen()),
                      (route) => false);
                },
                color: Colors.red,
                text: "Logout",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
