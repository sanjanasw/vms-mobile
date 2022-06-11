import 'VaccinationDetails.dart';

class User {
  String id;
  String nic;
  String firstname;
  String lastname;
  String email;
  String phoneNumber;
  int gender;
  String dob;
  String username;
  // List<VaccinationDetails> vaccinationDetails;

  User({
    this.nic,
    this.firstname,
    this.lastname,
    this.email,
    this.phoneNumber,
    this.gender,
    this.dob,
    this.username,
  });
}
