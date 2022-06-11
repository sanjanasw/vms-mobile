import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:fyp/components/DefaultButton.dart';
import 'package:fyp/mainHomePage.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fyp/screens/onboarding/OnBoardingForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class SignForm extends StatefulWidget {
  const SignForm({
    Key key,
  }) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  _launchURL() async {
    const url = 'https://slvms.software/auth/forgot-password';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  login(String userName, String password) async {
    print(userName);
    var url = Uri.parse(kApiUrl + "auth/login");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {"userName": userName, "password": password};
    var body = json.encode(data);
    print(url);
    var jsonResponse;
    try {
      var res = await http.post(url,
          headers: {"Content-Type": "application/json"}, body: body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        jsonResponse = json.decode(res.body);
        print("Response Status: ${res.statusCode}");
        if (res.statusCode == 403) {
          print(json.decode(res.body));
        }

        if (jsonResponse != null) {
          sharedPreferences.setString("token", jsonResponse['token']);
          sharedPreferences.setString("name", jsonResponse['userName']);

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => HomePage()),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
      if (res.statusCode == 401) {
        setState(() {
          _isLoading = false;
        });
        print(_passwordController.text);
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Incorrect Email or Password");
      }
      if (res.statusCode == 503) {
        print("Server under maintenance, Please check after a while ");
      } else if (res.statusCode == 401) {
        print(json.decode(res.body));
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: _emailController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: "Enter your username",
              labelText: "Username",
              suffixIcon: Icon(Icons.account_circle),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            cursorColor: Colors.black,
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.lock,
              ),
              hintText: "Enter your password",
              labelText: "Password",
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _launchURL,
                child: Text("Forgot password?"),
              ),
            ],
          ),

          SizedBox(
            height: 30,
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                minimumSize: Size.fromHeight(55),
              ),
              onPressed: () async {
                FocusScope.of(context).requestFocus(new FocusNode());

                setState(() {
                  _isLoading = true;
                });
                login(_emailController.text, _passwordController.text);
              },
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Text("Please Wait.."),
                      ],
                    )
                  : Text("Login"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                GestureDetector(
                  onTap: () => Navigator.popAndPushNamed(
                      context, OnBoardingForm.routeName),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          // DefaultButton(
          //   press: () {
          //     login(_emailController.text, _passwordController.text);
          //   },
          //   text: "Login",
          // ),
        ],
      ),
    );
  }
}
