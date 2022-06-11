import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CovidReport extends StatefulWidget {
  static String routeName = '/covidReportScreen';

  @override
  State<CovidReport> createState() => _CovidReportState();
}

class _CovidReportState extends State<CovidReport> {
  String totalConfirmed;
  String dailyCases;
  String activeCases;
  String recovered;
  String deaths;

  Future getHPBDetails() async {
    http.Response response;
    Map data;

    String url = "https://www.hpb.health.gov.lk/api/get-current-statistical";

    response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body != null) {
        data = json.decode(response.body)['data'];
        totalConfirmed = data['local_total_cases'].toString();
        dailyCases = data['local_new_cases'].toString();
        activeCases = data['local_active_cases'].toString();
        recovered = data['local_recovered'].toString();
        deaths = data['local_deaths'].toString();
      }
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("COVID-19 Situation Report"),
      ),
      body: FutureBuilder(
          future: getHPBDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 6),
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/buidling.png",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            totalConfirmed,
                            style: TextStyle(
                              fontSize: 42,
                              color: Color.fromRGBO(253, 183, 47, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Total Confirmed \nCases",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/activeCases.png",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            activeCases,
                            style: TextStyle(
                              fontSize: 42,
                              color: Color.fromRGBO(228, 62, 57, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Active Cases",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/ambulance.png",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            dailyCases,
                            style: TextStyle(
                              fontSize: 42,
                              color: Color.fromRGBO(112, 82, 251, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Daily Cases",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/runningMan.png",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            recovered,
                            style: TextStyle(
                              fontSize: 42,
                              color: Color.fromRGBO(80, 205, 138, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Recovered",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              "assets/images/deadBed.png",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            deaths,
                            style: TextStyle(
                              fontSize: 42,
                              color: Color.fromRGBO(246, 74, 143, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Deaths",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
