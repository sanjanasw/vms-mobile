import 'package:flutter/material.dart';

class UserCardDetails extends StatelessWidget {
  final String category;
  final String detail;

  const UserCardDetails({Key key, this.category, this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          category,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          detail,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
