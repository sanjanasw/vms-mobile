import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourAppointmentCard extends StatefulWidget {
  String vaccineType;
  String batchNo;
  String date;
  String location;
  int status;
  int id;

  YourAppointmentCard(
      {this.vaccineType,
      this.batchNo,
      this.date,
      this.location,
      this.status,
      this.id});

  @override
  State<YourAppointmentCard> createState() => _YourAppointmentCardState();
}

class _YourAppointmentCardState extends State<YourAppointmentCard> {
  Color statusColor;
  String statusText;

  Color colorDetails() {
    if (widget.status == 0) {
      return statusColor = Colors.black;
    }
    if (widget.status == 1) {
      return statusColor = Colors.green.shade800;
    }
    if (widget.status == 2) {
      return statusColor = Colors.cyan;
    }
    return Colors.red.shade800;
  }

  String text() {
    if (widget.status == 0) {
      return "On Going";
    }
    if (widget.status == 1) {
      return "Completed";
    }
    if (widget.status == 2) {
      return "Expired";
    }
    if (widget.status == 3) {
      return "Cancelled";
    }
    return "";
  }

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('appointmentId', widget.id);
        setState(() {
          this.value = !value;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: 600,
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 3,
            color: colorDetails(),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5, bottom: 3),
                      child: Image(
                        image: AssetImage("assets/images/bottle.png"),
                        color: Colors.black,
                        height: 30,
                        width: 40,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        widget.vaccineType,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Checkbox(
                        activeColor: Colors.black,
                        value: value,
                        onChanged: (value) {}),
                  ],
                ),
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
                    widget.batchNo,
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
                    color: Colors.black,
                    height: 30,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.date,
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
                    child: Text(
                      widget.location,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/heartbeat.png"),
                    color: colorDetails(),
                    height: 30,
                    width: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    text(),
                    style: TextStyle(
                      fontSize: 18,
                      color: colorDetails(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
