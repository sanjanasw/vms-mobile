// import 'package:flutter/material.dart';
// import 'package:fyp/screens/onboarding/components/CardDetails.dart';
// import 'package:fyp/screens/onboarding/components/WelcomeText.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class PersonalDetailsStep extends StatelessWidget {
//   Map userDetails;
//   String date;
//
//   Future getUserDetails() async {
//     http.Response response;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     String nic = (prefs.getString("nic") ?? '');
//     String url = "https://sl-citizens.azurewebsites.net/Citizen/$nic";
//
//     response = await http.get(url, headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     });
//
//     if (response.body != null) {
//       userDetails = json.decode(response.body);
//
//       //date = DateFormat("dd-MM-yyyy").format(userDetails['dateOfBirth']);
//
//       // id = userData['id'];
//       // username = userData['username'];
//       // email = userData['email'];
//       // phoneNumber = userData['phoneNumber'];
//
//     }
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(userDetails);
//     }
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
// }
