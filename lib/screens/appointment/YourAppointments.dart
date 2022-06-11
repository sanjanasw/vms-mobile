import 'package:another_flushbar/flushbar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fyp/apiConstants.dart';
import 'package:fyp/components/MainAppBar.dart';
import 'components/YourAppointmentCard.dart';
import 'package:fyp/components/DefaultButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fyp/screens/appointment/BookAppointment.dart';

class Appointment extends StatefulWidget {
  static String routeName = '/appointmentScreen';

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  List<Widget> appointmentCards = [];
  bool value = true;
  bool _isLoading = false;

  Future cancelAppointment() async {
    CoolAlert.show(context: context, type: CoolAlertType.loading);
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    int id = (prefs.getInt('appointmentId') ?? '');
    String url = "$kApiUrl/appointment/cancel/$id";

    response = await http.put(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response);
    Navigator.pop(context);
    setState(() {});
    if (response.statusCode == 200) {
      await Flushbar(
        title: "Appointment Cancelled",
        message: "Your appointment has successfully been cancelled ",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      await Flushbar(
        title: "Something went wrong",
        message: "Something went wrong please try again later",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
  }

  Future getAppointments() async {
    http.Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    //String url = "https://vms-sl.azurewebsites.net/user/appointments";

    response = await http.get(kApiUrl + 'user/appointments', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.body != null) {
      List appointmentData = [];

      appointmentData = json.decode(response.body);
      print(appointmentData);
      appointmentCards.clear();

      print(appointmentData);
      for (int i = 0; i < appointmentData.length; i++) {
        appointmentCards.add(
          YourAppointmentCard(
            vaccineType: appointmentData[i]['vaccine'],
            batchNo: appointmentData[i]['batchNumber'],
            date: appointmentData[i]['date'],
            location: appointmentData[i]['vCenter'],
            status: appointmentData[i]['status'],
            id: appointmentData[i]['id'],
          ),
        );
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: SafeArea(
          child: MainAppBar(),
        ),
      ),
      body: FutureBuilder(
          future: getAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        " Your Appointments",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: appointmentCards.isEmpty
                            ? [
                                SizedBox(height: 40),
                                Text(
                                  "You don't have any appointments \n Book an appointment and get vaccinated :)",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 140),
                              ]
                            : appointmentCards,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // DefaultButton(
                      //   color: Colors.green,
                      //   text: "Add to calendar",
                      //   press: () {},
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // DefaultButton(
                      //   color: Color.fromRGBO(68, 198, 252, 1),
                      //   text: "Get directions",
                      //   press: () {},
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            minimumSize: Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: appointmentCards.isEmpty
                              ? null
                              : () {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.confirm,
                                      onConfirmBtnTap: () async {
                                        Navigator.pop(context);
                                        await cancelAppointment();
                                      });
                                },
                          child: Text(
                            "Cancel appointment",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                      // DefaultButton(
                      //   color: Color.fromRGBO(251, 70, 70, 1),
                      //   text: "Cancel appointment",
                      //   press: () {
                      //     CoolAlert.show(
                      //         context: context,
                      //         type: CoolAlertType.confirm,
                      //         onConfirmBtnTap: () {
                      //           setState(() {
                      //             cancelAppointment();
                      //           });
                      //           Navigator.pop(context);
                      //         });
                      //   },
                      // ),
                      SizedBox(
                        height: 20,
                      ),

                      DefaultButton(
                        text: "Book An Appointment",
                        press: () {
                          Navigator.pushNamed(
                              context, BookAppointment.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
