import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:fyp/components/DefaultButton.dart';
import 'package:fyp/screens/appointment/YourAppointments.dart';
import 'package:fyp/screens/profile/components/YourAccountDetails.dart';
import 'package:intl/intl.dart';
import 'components/BookingDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookAppointment extends StatefulWidget {
  static String routeName = '/bookAppointment';
  var date;

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  List<Widget> appointmentCard = [];
  bool _isLoading = false;

  void listOfWidgets(var vaccinationData) {
    appointmentCard.clear();

    print("data received");
    print(vaccinationData);
    for (int i = 0; i < vaccinationData.length; i++) {
      appointmentCard.add(
        BookingDetails(
          id: vaccinationData[i]['id'],
          date: _dateTime,
          appointmentCount: vaccinationData[i]['todayAppointments'],
          maxLimit: vaccinationData[i]['maxDailyLimit'],
          dose: vaccinationData[i]['vaccine'],
          batchNumber: vaccinationData[i]['batchNumber'],
          vCenter: vaccinationData[i]['name'],
          isActive: vaccinationData[i]['vaccinatedAt'],
        ),
      );
    }
    print(appointmentCard);
  }

  Future apiCall(String district, String date) async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    String url = "${kApiUrl + 'v-center/filter/' + district}?date=$date";

    print(url);
    response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.body != null) {
      var vaccinationData = [];
      vaccinationData = json.decode(response.body);
      if (vaccinationData.length > 0) {
        listOfWidgets(vaccinationData);
      } else {
        appointmentCard.clear();
        appointmentCard.add(Text("No Center found!"));
      }
    }

    return response.body;
  }

  void initState() {
    // TODO: implement initState

    super.initState();
  }

  DateTime _dateTime = DateTime.now();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("BOOK AN APPOINTMENT"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Find your vaccination center",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Divider(
                  thickness: 1.2,
                  color: Color.fromRGBO(132, 135, 142, 1),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
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
                        appointmentCard.clear();
                        appointmentCard
                            .add(Center(child: CircularProgressIndicator()));
                        apiCall(selectedDistrict,
                            DateFormat("MM/dd/yyyy").format(_dateTime));
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Select a vaccination date",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Divider(
                  thickness: 1.2,
                  color: Color.fromRGBO(132, 135, 142, 1),
                ),
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    builder: (context, child) => Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: Colors.black,
                        accentColor: Colors.black,
                        colorScheme: ColorScheme.light(primary: Colors.black),
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.primary),
                      ),
                      child: child,
                    ),
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2222),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                      appointmentCard.clear();
                      appointmentCard
                          .add(Center(child: CircularProgressIndicator()));
                      apiCall(selectedDistrict,
                          DateFormat("MM/dd/yyyy").format(_dateTime));
                    });
                  });
                },
                child: SizedBox(
                  height: 60,
                  width: 500,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      _dateTime == null
                          ? "Select a date"
                          : DateFormat("yMd").format(_dateTime),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: apiCall(
                    selectedDistrict,
                    DateFormat("MM/dd/yyyy").format(_dateTime),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: appointmentCard,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
              // BookingDetails(),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
