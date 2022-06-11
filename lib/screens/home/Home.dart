import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:fyp/components/MainAppBar.dart';
import 'package:fyp/components/VaccineDetailsCard.dart';
import 'package:fyp/components/VaccineStatusCard.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  static String routeName = '/homeScreen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> vaccinationCard = [];

  Future apiCall() async {
    Map mapResponse;
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    // String url = "https://vms-sl.azurewebsites.net/user/profile";

    response = await http.get(kApiUrl + 'user/profile', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.body;
  }

  void listOfWidgets(var vaccinationData) {
    vaccinationCard.clear();
    print(vaccinationData);
    for (int i = 0; i < vaccinationData.length; i++) {
      vaccinationCard.add(
        VaccineDetailsCard(
          vaccineDoseNumber: i + 1,
          dose: vaccinationData[i]['vaccineType'],
          batchNumber: vaccinationData[i]['batchNumber'],
          vCenter: vaccinationData[i]['vCenter'].toString(),
          vaccinatedAt: vaccinationData[i]['vaccinatedAt'],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: SafeArea(
            child: MainAppBar(),
          ),
        ),
        body: FutureBuilder(
          future: apiCall(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              var userDataResponse = json.decode(snapshot.data);
              var vaccinationData = [];
              vaccinationData = userDataResponse['vaccinationData'];
              if (vaccinationData.length > 0) {
                listOfWidgets(vaccinationData);
              }
              print(vaccinationData.length);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          VaccineStatusCard(
                            nic: userDataResponse['nic'],
                            userName: userDataResponse['username'],
                            vaccineCount: vaccinationData.length,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Vaccination Details",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            color: Color.fromRGBO(132, 135, 142, 1),
                            thickness: 0.8,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ] +
                        vaccinationCard,
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
