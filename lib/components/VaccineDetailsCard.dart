import 'package:flutter/material.dart';

class VaccineDetailsCard extends StatelessWidget {
  final int vaccineDoseNumber;
  final String dose;
  final String batchNumber;
  final String vCenter;
  final String vaccinatedAt;

  VaccineDetailsCard(
      {this.vaccineDoseNumber,
      this.dose,
      this.batchNumber,
      this.vCenter,
      this.vaccinatedAt});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 12),
          width: 600,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 3,
              color: Colors.black,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 50, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/images/vaccineFilled.png"),
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      dose,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 27,
                      child: Image(
                        image: AssetImage("assets/images/injectionFilled.png"),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      batchNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: 40,
                      child: Image(
                        image:
                            AssetImage("assets/images/vaccinationFilled.png"),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      vaccinatedAt,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 27,
                      child: Image(
                        image: AssetImage("assets/images/pharmacyFilled.png"),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        vCenter,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 50,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Text(
            vaccineDoseNumber.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
        ),
      ],
    );
  }
}
