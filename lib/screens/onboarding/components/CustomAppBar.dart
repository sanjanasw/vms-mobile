import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              'assets/images/logo.png',
            ),
            width: 60,
            height: 60,
          ),
          SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 7),
              Text(
                "Health Promotion Bureau",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              Text(
                "Vaccine Management System",
                textAlign: TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
