import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VaccineStatusCard extends StatelessWidget {
  final String userName;
  final String nic;
  final int vaccineCount;
  String vaccinationData;
  Color topColor;
  Color bottomColor;

  VaccineStatusCard({this.userName, this.nic, this.vaccineCount}) {
    switch (vaccineCount) {
      case 0:
        vaccinationData = "Not Vaccinated";
        topColor = Color.fromRGBO(203, 0, 0, 1);
        bottomColor = Color.fromRGBO(251, 70, 70, 1);

        break;
      case 1:
        vaccinationData = "Partially Vaccinated";
        topColor = Color.fromRGBO(218, 118, 0, 1);
        bottomColor = Color.fromRGBO(251, 189, 70, 1);
        break;
      case 2:
        vaccinationData = "Fully Vaccinated";
        topColor = Color.fromRGBO(0, 189, 76, 1);
        bottomColor = Color.fromRGBO(59, 240, 132, 1);
        break;
      default:
        vaccinationData = "Boosted X" + (vaccineCount - 2).toString();
        topColor = Color.fromRGBO(0, 137, 193, 1);
        bottomColor = Color.fromRGBO(68, 198, 252, 1);
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: bottomColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 80, left: 10, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Vaccination Status",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      vaccinationData,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 23, right: 23, bottom: 23),
          width: 600,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: topColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nic,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 25,
          left: 200,
          child: QrImage(
            data: 'https://slvms.software/' + 'vaccination-card/' + userName,
            size: 120,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
