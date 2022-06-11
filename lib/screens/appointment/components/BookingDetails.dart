import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fyp/mainHomePage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../apiConstants.dart';
import '../YourAppointments.dart';

class BookingDetails extends StatefulWidget {
  final int id;
  final String dose;
  final String batchNumber;
  final String vCenter;
  final int maxLimit;
  final bool isActive;
  final DateTime date;
  final int appointmentCount;

  BookingDetails({
    this.id,
    this.dose,
    this.date,
    this.batchNumber,
    this.vCenter,
    this.maxLimit,
    this.isActive,
    this.appointmentCount,
  });

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  bool value = false;

  bool _isSelected = false;
  sendAppointment() async {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        text: "Please wait...",
        title: "Booking your appointment");
    var url = Uri.parse(kApiUrl + 'appointment');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = (prefs.getString('token') ?? '');
    String vCenter = (prefs.getInt('vCenterId') ?? '');
    print(vCenter);
    Map data = {
      "vCenterId": this.widget.id,
      "date": DateFormat("MM/dd/yyyy").format(widget.date),
    };
    var body = json.encode(data);
    print(url);
    print(data);
    var jsonResponse;
    try {
      var res = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: body);
      Navigator.pop(context);
      var response = await jsonDecode(res.body);
      print(response);
      print(res.statusCode);
      if (res.statusCode == 409) {
        await Flushbar(
                backgroundColor: Colors.red.shade600,
                borderRadius: BorderRadius.circular(10),
                duration: Duration(seconds: 3),
                title: "Something went wrong",
                message: response['message'],
                flushbarPosition: FlushbarPosition.TOP)
            .show(context);
      }
      if (res.statusCode == 200) {
        await Flushbar(
                backgroundColor: Colors.green.shade800,
                borderRadius: BorderRadius.circular(10),
                duration: Duration(seconds: 2),
                title: "Booked Successfully ",
                message: response['message'],
                flushbarPosition: FlushbarPosition.TOP)
            .show(context);
        Navigator.pushNamed(context, HomePage.routeName);
      } else {
        await Flushbar(
                backgroundColor: Colors.red.shade800,
                borderRadius: BorderRadius.circular(10),
                duration: Duration(seconds: 3),
                title: "Something went wrong ",
                message: response['message'],
                flushbarPosition: FlushbarPosition.TOP)
            .show(context);
        Navigator.popAndPushNamed(context, HomePage.routeName);
      }
    } catch (error) {}
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color _checkColor() {
      if (widget.isActive == false &&
          widget.appointmentCount < widget.maxLimit &&
          value == false) {
        return Colors.red;
      } else if (widget.appointmentCount >= widget.maxLimit &&
          value == false &&
          widget.isActive == true) {
        return Colors.amber;
      } else if (value == false) {
        return Colors.green.shade800;
      } else if (value == true) {
        return Color.fromRGBO(59, 240, 132, 1);
      } else {
        return Colors.pink;
      }
    }

    Text _checkText() {
      if (widget.isActive == false) {
        return Text("LOCATION INACTIVE", style: TextStyle(color: Colors.white));
      }
      if (widget.appointmentCount >= widget.maxLimit) {
        return Text("LOCATION FULL", style: TextStyle(color: Colors.white));
      }
      if (value == true) {
        return Text("Selected");
      } else
        return Text("Select");
    }

    int spotCount = widget.maxLimit - widget.appointmentCount;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 600,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 3,
                color: _checkColor(),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/bottle.png"),
                        color: Colors.black,
                        height: 30,
                        width: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.dose,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/injection2.png"),
                        color: Colors.black,
                        height: 30,
                        width: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.batchNumber,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/calendar2.png"),
                        color: Colors.black87,
                        height: 30,
                        width: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        spotCount.toString() +
                            "/" +
                            widget.maxLimit.toString() +
                            " spots left",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage("assets/images/hospital.png"),
                        color: Colors.black,
                        height: 30,
                        width: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            widget.vCenter,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          textColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          disabledTextColor: Colors.grey,
                          disabledColor: _checkColor(),
                          color: _checkColor(),
                          //color: _checkColor(),
                          onPressed: () async {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.confirm,
                                backgroundColor: Colors.black,
                                title: "Confirm booking",
                                onConfirmBtnTap: () async {
                                  Navigator.pop(context);

                                  sendAppointment();
                                },
                                onCancelBtnTap: () {
                                  Navigator.pop(context);
                                });
                            // if (value) {
                            //   SharedPreferences sharedPreferences =
                            //       await SharedPreferences.getInstance();
                            //   sharedPreferences.setInt('vCenterId', widget.id);
                            // }
                          },
                          child: _checkText(),
                        ),
                      ),
                    ],
                  ),
                  // button(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
