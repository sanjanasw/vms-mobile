import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import "package:fyp/components/DefaultButton.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YourAccountDetails extends StatefulWidget {
  @override
  State<YourAccountDetails> createState() => _YourAccountDetailsState();
}

class _YourAccountDetailsState extends State<YourAccountDetails> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var email;
  var username;
  var id;
  var phoneNumber;
  var nic;
  var firstName;
  var lastName;
  var gender;
  var dob;
  Map userData;

  Future getAccountDetails() async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    String url = kApiUrl + 'user/profile';

    response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.body != null) {
      userData = json.decode(response.body);
      id = userData['id'];
      username = userData['username'];
      email = userData['email'];
      phoneNumber = userData['phoneNumber'];
      nic = userData['nic'];
      firstName = userData['firstName'];
      lastName = userData['lastName'];
      gender = userData['gender'];
      dob = userData['dob'];
      prefs.setString('UserID', userData['id']);
    }

    return true;
  }

  updateAccountDetails() async {
    var url = Uri.parse("$kApiUrl/user/$id");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    Map data = {
      "id": id,
      "email": _email.text,
      "username": _username.text,
      "phoneNumber": _phoneNumber.text,
      "nic": nic,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "dob": dob,
    };
    var body = json.encode(data);

    var jsonResponse;
    try {
      var res = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);
      print(res.statusCode);
      if (res.statusCode == 400) {
        CoolAlert.show(context: context, type: CoolAlertType.error);
      }
      if (res.statusCode == 200) {
        print(json.decode(body));
        _username.clear();
        _email.clear();
        _phoneNumber.clear();
        CoolAlert.show(context: context, type: CoolAlertType.success);

        if (jsonResponse != null) {}
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAccountDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      hintText: username,
                      labelText: "Username",
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Username can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: email,
                      labelText: "Email",
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Email can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      hintText: phoneNumber.toString(),
                      labelText: "Phone number",
                    ),
                    validator: (value) {
                      if (value.isEmpty) return "Phone number can't be empty";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  DefaultButton(
                    press: () {
                      if (_formKey.currentState.validate()) {
                        updateAccountDetails();
                      }
                    },
                    text: "Update Details",
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
