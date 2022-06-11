import 'package:flutter/material.dart';
import 'package:fyp/mainHomePage.dart';
import 'package:fyp/screens/appointment/BookAppointment.dart';
import 'package:fyp/screens/information/Infromation.dart';
import 'package:fyp/screens/login/Login.dart';
import 'package:fyp/screens/onboarding/OnBoardingForm.dart';
import 'package:fyp/screens/profile/Profile.dart';
import 'package:fyp/screens/services/Services.dart';
import 'package:fyp/screens/services/services%20sub%20screens/QrScanner.dart';
import 'screens/home/Home.dart';
import 'screens/appointment/YourAppointments.dart';
import 'screens/information/information sub screens/ContactLists.dart';
import 'screens/information/information sub screens/CovidReport.dart';
import 'screens/information/information sub screens/PreVaccineCheckList.dart';
import 'screens/information/information sub screens/VaccineInformation.dart';
import 'screens/services/services sub screens/ReportSymptoms.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  Home.routeName: (context) => Home(),
  Appointment.routeName: (context) => Appointment(),
  Services.routeName: (context) => Services(),
  Profile.routeName: (context) => Profile(),
  Information.routeName: (context) => Information(),
  BookAppointment.routeName: (context) => BookAppointment(),
  ContactList.routeName: (context) => ContactList(),
  CovidReport.routeName: (context) => CovidReport(),
  PreVaccineCheckList.routeName: (context) => PreVaccineCheckList(),
  VaccineInformation.routeName: (context) => VaccineInformation(),
  ReportSymptoms.routeName: (context) => ReportSymptoms(),
  OnBoardingForm.routeName: (context) => OnBoardingForm(),
  CustomQrScanner.routeName: (context) => CustomQrScanner(),
  HomePage.routeName: (context) => HomePage(),
};
