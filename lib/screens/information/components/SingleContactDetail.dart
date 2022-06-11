import 'package:flutter/material.dart';

class SingleContactDetail extends StatelessWidget {
  final String number;
  final String contactName;
  SingleContactDetail({this.number, this.contactName});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                contactName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            number,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
