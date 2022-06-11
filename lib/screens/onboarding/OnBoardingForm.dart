import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:fyp/screens/login/Login.dart';
import 'components/CardDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'components/WelcomeText.dart';

import 'Steps/EmailStep.dart';
import 'components/CustomAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingForm extends StatefulWidget {
  static String routeName = '/onBoarding';
  @override
  _OnBoardingFormState createState() => _OnBoardingFormState();
}

class _OnBoardingFormState extends State<OnBoardingForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map userDetails;
  String nic;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _gender = TextEditingController();
  int currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicController = TextEditingController();
  var res;
  var getRes;
  bool _isloading = false;
  Future<void> getUserDetails() async {
    http.Response response;
    nic = _nicController.text;

    String url = "$kCitizenApiUrl/Citizen/$nic";

    response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response.statusCode);

    if (response.body != null && response.statusCode == 200) {
      userDetails = await json.decode(response.body);
      _isloading = false;
    }
    print(response.body);
    setState(() {
      getRes = response.statusCode;
      _isloading = false;
    });
  }

  Widget checkStatus() {
    switch (getRes) {
      case 200:
        return _isloading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  WelcomeText(),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your personal details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          UserCardDetails(
                            category: "NIC",
                            detail: userDetails['nic'],
                          ),
                          UserCardDetails(
                            category: "Full Name",
                            detail: userDetails['firstName'],
                          ),
                          UserCardDetails(
                            category: "Last Name",
                            detail: userDetails['lastName'],
                          ),
                          UserCardDetails(
                            category: "Date of Birth",
                            detail: userDetails['dateOfBirth'],
                          ),
                          UserCardDetails(
                            category: "Street",
                            detail: userDetails['street'],
                          ),
                          UserCardDetails(
                            category: "City",
                            detail: userDetails['city'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                ],
              );
      case 500:
        return _isloading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Text(
                    "No user found under the given NIC, Please check the NIC entered again ",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(170, 40)),
                      onPressed: () {
                        setState(() {
                          currentStep--;
                        });
                      },
                      child: Text(" Back")),
                ],
              );
      case 404:
        return Column(
          children: [
            Text(
              "No user found under the given NIC, Please check the NIC entered again ",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(170, 40)),
                onPressed: () {
                  setState(() {
                    currentStep--;
                  });
                },
                child: Text(" Back")),
          ],
        );
      default:
        return Text("Something went wrong");
    }
  }

  registerUser() async {
    print("reoccuring");
    var url = Uri.parse(kApiUrl + 'auth/register');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map data = {
      "nic": nic,
      "firstName": userDetails['firstName'],
      "lastName": userDetails['lastName'],
      "username": _username.text,
      "email": _email.text,
      "phoneNumber": _phone.text.toString(),
      "password": _password.text,
      "gender": userDetails['gender'],
      "dob": userDetails["dateOfBirth"],
    };
    print(data);
    var body = json.encode(data);

    try {
      res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: body);
      print(res.statusCode);

      if (res.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
        ));
      }
      if (res.statusCode == 200) {
        var jsonResponse = json.decode(res.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Found'),
          backgroundColor: Colors.green,
        ));
        print("Response Status: ${res.statusCode}");
      }
    } catch (error) {
      print(error);
    }
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(""),
          content: Column(
            children: <Widget>[
              WelcomeText(),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _nicController,
                decoration: InputDecoration(
                  hintText: "Enter your NIC",
                  labelText: "National Identity",
                ),
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text(""),
          content: _isloading
              ? Center(child: CircularProgressIndicator())
              : checkStatus(),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text(""),
          content: Column(
            children: <Widget>[
              WelcomeText(),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Username",
                        labelText: "username",
                        suffixIcon: Icon(Icons.person_rounded),
                      ),
                      controller: _username,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Username can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        labelText: "Email",
                        suffixIcon: Icon(Icons.mail),
                      ),
                      controller: _email,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        labelText: "Password",
                        suffixIcon: Icon(Icons.lock),
                      ),
                      controller: _password,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Confirm password",
                        labelText: "Confirm password",
                        suffixIcon: Icon(Icons.lock),
                      ),
                      controller: _confirmPassword,
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
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                        labelText: "Phone number",
                        suffixIcon: Icon(Icons.phone),
                      ),
                      controller: _phone,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Phone number can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 23,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text(""),
          content: EmailStep(email: _email.text),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: CustomAppBar(),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.black,
          ),
          primaryColor: Colors.black,
          shadowColor: Colors.transparent,
          canvasColor: Colors.white,
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (currentStep == 0)
                  Container(
                    height: 50,
                    width: 300,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_nicController.text.isEmpty) {
                          print("cant be empty");
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("NIC can't be empty")));
                        }
                        if (_nicController.text.isNotEmpty) {
                          setState(() {
                            _isloading = true;
                          });
                          getUserDetails();
                          print(_nicController.text);
                          print("not empty");
                          setState(() {
                            currentStep += 1;
                          });
                        }
                      },
                      child: const Text(
                        'Check Identity',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (currentStep == 1)
                  _isloading
                      ? SizedBox()
                      : getRes == 200
                          ? Container(
                              height: 50,
                              width: 300,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentStep += 1;
                                  });
                                },
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                if (currentStep == 2)
                  Container(
                    height: 50,
                    width: 300,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print("sucessfull");
                          registerUser();
                          setState(() {
                            currentStep += 1;
                          });
                          if (res.statusCode == 400) {
                            CoolAlert.show(
                                context: context, type: CoolAlertType.error);
                          }
                          if (res.statusCode == 403) {
                            print(json.decode(res.body));
                          }
                        } else {
                          print("unsucessfull");
                        }
                      },
                    ),
                  ),
                if (currentStep == 3)
                  Container(
                    height: 50,
                    width: 300,
                    child: TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        final isLastStep = currentStep == getSteps().length - 1;
                        if (isLastStep) {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        }
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
