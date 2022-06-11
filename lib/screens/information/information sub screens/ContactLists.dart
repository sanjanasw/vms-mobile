import 'package:flutter/material.dart';

import '../components/SingleContactDetail.dart';

class ContactList extends StatelessWidget {
  static String routeName = '/contactsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HPB Contact Numbers"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleContactDetail(
                contactName: "Health Promotion Bureau", number: "011 2696606"),
            SingleContactDetail(
                contactName: "Health Promotion Bureau", number: "011 2696142"),
            SingleContactDetail(
                contactName: "Suwasariya Hotline", number: "1999"),
            SingleContactDetail(
                contactName: "Epidemiology Unit", number: "011 269511"),
            SingleContactDetail(
                contactName: "Quarantine Unit", number: "0112112705"),
            SingleContactDetail(
                contactName: "Disaster Management Unit", number: "0113071073"),
          ],
        ),
      ),
    );
  }
}
