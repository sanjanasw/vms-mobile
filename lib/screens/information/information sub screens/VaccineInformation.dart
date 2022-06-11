import 'package:flutter/material.dart';

import '../components/VaccineInformationCard.dart';

class VaccineInformation extends StatelessWidget {
  static String routeName = '/VaccineInformationScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccine Information"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Center(
                child: Text(
                  "7 vaccines approved for use in Sri-Lanka",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              VaccineInformationCard(
                  color: Color.fromRGBO(255, 149, 71, 1),
                  countryApproved: "85",
                  vaccineCompany: "SPIKEVAX",
                  vaccineType: "Moderna",
                  vaccinePoly: "RNA"),
              SizedBox(height: 10),
              VaccineInformationCard(
                  color: Color.fromRGBO(255, 149, 71, 1),
                  countryApproved: "137",
                  vaccineType: "Pfizer/BioNTech",
                  vaccineCompany: "COMIRNATY",
                  vaccinePoly: "RNA"),
              SizedBox(height: 10),
              VaccineInformationCard(
                  color: Color.fromRGBO(227, 117, 182, 1),
                  countryApproved: "74",
                  vaccineCompany: "SPUTNIK V",
                  vaccineType: "Gamaleya",
                  vaccinePoly: "Non Replicating Viral Vector"),
              SizedBox(height: 10),
              VaccineInformationCard(
                color: Color.fromRGBO(227, 117, 182, 1),
                countryApproved: "137",
                vaccineCompany: "Vaxzevria",
                vaccineType: "Oxford/AstraZeneca",
                vaccinePoly: "Non Replicating Viral Vector",
              ),
              SizedBox(height: 10),
              VaccineInformationCard(
                color: Color.fromRGBO(227, 117, 182, 1),
                countryApproved: "89",
                vaccineCompany: "Covilo",
                vaccineType: "Sinopharm (Beijing)",
                vaccinePoly: "Non Replicating Viral Vector",
              ),
              SizedBox(height: 10),
              VaccineInformationCard(
                color: Color.fromRGBO(181, 124, 200, 1),
                countryApproved: "47",
                vaccineCompany: "Covishield",
                vaccineType: "Serum Institute of India",
                vaccinePoly: "Non Replicating Viral Vector",
              ),
              SizedBox(height: 10),
              VaccineInformationCard(
                color: Color.fromRGBO(181, 124, 200, 1),
                countryApproved: "53",
                vaccineCompany: "CoronaVac",
                vaccineType: "Sinovac",
                vaccinePoly: "Non Replicating Viral Vector",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
