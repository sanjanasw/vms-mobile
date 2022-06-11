import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class ReportSymptoms extends StatefulWidget {
  static String routeName = '/ReportSystemsScreen';

  @override
  _ReportSymptomsState createState() => _ReportSymptomsState();
}

class _ReportSymptomsState extends State<ReportSymptoms> {
  String selectedDistrict = "Colombo";

  DropdownMenuItem buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      );
  final items = [
    "Colombo",
    "Gampaha",
    "Kalutara",
    "Kandy",
    "Matale",
    "Nuwara Eliya",
    "Galle",
    "Matara",
    "Hambantota",
    "Jaffna",
    "Kilinochchi",
    "Mannar",
    "Vavuniya",
    "Mullaitivu",
    "Batticaloa",
    "Ampara",
    "Trincomalee",
    "Kurunegala",
    "Puttalam",
    "Anuradhapura",
    "Polonnaruwa",
    "Badulla",
    "Moneragala",
    "Ratnapura",
    "Kegalle",
  ];
  bool _symptomsValue;
  bool _covidTestValue;
  bool _resultValue;
  bool _isVisible = false;
  int counter = 0;
  Future sendReport() async {
    CoolAlert.show(
        context: context, type: CoolAlertType.loading, text: "Please wait...");
    var url = Uri.parse(kApiUrl + 'report/report-symptoms');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    Map data = {
      "district": selectedDistrict,
      "isSymptom": _symptomsValue,
      "isTested": _covidTestValue,
      "isPositive": _resultValue,
    };
    var body = json.encode(data);

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
      Navigator.pop(context);
      if (res.statusCode == 405) {
        CoolAlert.show(context: context, type: CoolAlertType.error);
      }
      if (res.statusCode == 200) {
        print(json.decode(body));

        CoolAlert.show(context: context, type: CoolAlertType.success);

        if (jsonResponse != null) {}
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Symptoms"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Location",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconSize: 35,
                    isExpanded: true,
                    value: selectedDistrict,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Do you have any of the following symptoms?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                "cough, fever, loss of smell, brain fog?",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              RadioListTile<bool>(
                value: true,
                groupValue: _symptomsValue,
                onChanged: (val) {
                  setState(() {
                    _symptomsValue = val;
                    counter++;
                  });
                },
                activeColor: Colors.black,
                title: Text("Yes"),
              ),
              RadioListTile<bool>(
                value: false,
                groupValue: _symptomsValue,
                onChanged: (val) {
                  setState(() {
                    _symptomsValue = val;
                    counter--;
                  });
                },
                activeColor: Colors.black,
                title: Text("No"),
              ),
              Text(
                "Did you take a covid test?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RadioListTile<bool>(
                value: true,
                groupValue: _covidTestValue,
                onChanged: (val) {
                  setState(() {
                    _isVisible = true;
                    counter++;
                    _covidTestValue = val;
                  });
                },
                activeColor: Colors.black,
                title: Text("Yes"),
              ),
              RadioListTile<bool>(
                value: false,
                groupValue: _covidTestValue,
                onChanged: (val) {
                  setState(() {
                    counter--;
                    _isVisible = false;
                    _covidTestValue = val;
                  });
                },
                activeColor: Colors.black,
                title: Text("No"),
              ),
              Visibility(
                visible: _isVisible,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How did it turn out?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      RadioListTile<bool>(
                        value: true,
                        groupValue: _resultValue,
                        onChanged: (val) {
                          setState(() {
                            counter++;
                            _resultValue = val;
                          });
                        },
                        activeColor: Colors.black,
                        title: Text("Positive"),
                      ),
                      RadioListTile<bool>(
                        value: false,
                        groupValue: _resultValue,
                        onChanged: (val) {
                          setState(() {
                            counter--;
                            _resultValue = val;
                          });
                        },
                        activeColor: Colors.black,
                        title: Text("Negative"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: 350,
                  height: 40,
                  child: RaisedButton(
                      child: Text("SEND REPORT "),
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        sendReport();
                        print(_symptomsValue);
                        print(_covidTestValue);
                        print(_resultValue);
                      }),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
