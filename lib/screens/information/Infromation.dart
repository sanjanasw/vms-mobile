import 'package:flutter/material.dart';
import 'package:fyp/screens/information/information%20sub%20screens/ContactLists.dart';
import 'package:fyp/screens/information/information%20sub%20screens/CovidReport.dart';
import 'package:fyp/screens/information/information%20sub%20screens/PreVaccineCheckList.dart';
import 'package:fyp/screens/information/information%20sub%20screens/VaccineInformation.dart';

class Information extends StatelessWidget {
  static String routeName = '/informationScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain)),
        backgroundColor: Colors.black,
        title: Text("HPB VMS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InformationCard(
              title: "Vaccine Information",
              press: () {
                Navigator.pushNamed(context, VaccineInformation.routeName);
              },
            ),
            InformationCard(
              title: "COVID-19 Situation Report",
              press: () {
                Navigator.pushNamed(context, CovidReport.routeName);
              },
            ),
            InformationCard(
              title: "Pre-Vaccine Self-Check List",
              press: () {
                Navigator.pushNamed(context, PreVaccineCheckList.routeName);
              },
            ),
            InformationCard(
              title: "HPB Contact Numbers",
              press: () {
                Navigator.pushNamed(
                  context,
                  ContactList.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InformationCard extends StatelessWidget {
  InformationCard({this.title, this.press});
  final String title;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.black,
      onTap: press,
      child: Container(
        height: 80,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 27,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
