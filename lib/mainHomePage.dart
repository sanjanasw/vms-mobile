import 'package:flutter/material.dart';
import 'package:fyp/components/MainAppBar.dart';
import 'package:fyp/screens/home/Home.dart';
import 'package:fyp/screens/appointment/YourAppointments.dart';
import 'package:fyp/screens/information/Infromation.dart';
import 'package:fyp/screens/profile/Profile.dart';
import 'package:fyp/screens/services/Services.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      Home(),
      Appointment(),
      Services(),
      Information(),
      Profile(),
    ];
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/home.png"),
              ),
              backgroundColor: Colors.black,
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/injection.png"),
              ),
              backgroundColor: Colors.black,
              label: "Appointment",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/medicBag.png"),
              ),
              backgroundColor: Colors.black,
              label: "Services",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/information.png"),
              ),
              backgroundColor: Colors.black,
              label: "Information",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/user.png"),
              ),
              label: "Profile",
              backgroundColor: Colors.black,
            ),
          ],
        ),
        body: screens[currentIndex],
      ),
    );
  }
}
