import 'package:flutter/material.dart';
import 'package:fyp/screens/information/Infromation.dart';
import 'package:fyp/screens/services/services%20sub%20screens/QrScanner.dart';
import 'package:fyp/screens/services/services%20sub%20screens/ReportSymptoms.dart';

class Services extends StatelessWidget {
  static String routeName = '/servicesScreen';

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
      body: Column(
        children: [
          InformationCard(
            title: "Report Symptoms",
            press: () {
              Navigator.pushNamed(context, ReportSymptoms.routeName);
            },
          ),
          InformationCard(
            title: "QR Scanner",
            press: () {
              Navigator.pushNamed(context, CustomQrScanner.routeName);
            },
          ),
        ],
      ),
    );
  }
}
// Card(
// elevation: 2.5,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.all(Radius.circular(10)),
// ),
// color: Color.fromRGBO(230, 230, 230, 1),
// child: Column(
// children: <Widget>[
// Expanded(
// flex: 7,
// child: Container(
// height: 10,
// width: double.infinity,
// ),
// ),
// Expanded(
// flex: 3,
// child: Container(
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(10),
// bottomRight: Radius.circular(10)),
// ),
// width: double.infinity,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.all(10.0),
// child: Text(
// "Report \nSymptoms",
// style: TextStyle(
// fontSize: 16,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
