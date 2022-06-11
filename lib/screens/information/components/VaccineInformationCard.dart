import 'package:flutter/material.dart';

class VaccineInformationCard extends StatelessWidget {
  final Color color;
  final String vaccineType;
  final String vaccinePoly;
  final String countryApproved;
  final String vaccineCompany;

  VaccineInformationCard(
      {this.color,
      this.vaccineType,
      this.vaccinePoly,
      this.countryApproved,
      this.vaccineCompany});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                vaccineCompany,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 240,
            width: double.infinity,
          ),
          Positioned(
            top: 55,
            left: 3.5,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/images/bottle.png"),
                          color: Colors.black,
                          height: 25,
                          width: 23,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          vaccineType,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/injection2.png",
                          ),
                          color: Colors.black,
                          height: 25,
                          width: 23,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          vaccinePoly,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/approve.png",
                          ),
                          color: Colors.black,
                          height: 27,
                          width: 27,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Approved in " + countryApproved + " countries",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Read More",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 180,
              width: 313,
            ),
          ),
        ],
      ),
    );
  }
}
