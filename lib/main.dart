import 'package:flutter/material.dart';
import 'package:petrol_pump/LoginPage.dart';
import 'package:petrol_pump/OtpPage.dart';
import 'package:petrol_pump/profilePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: Color(0xFF265FFB),
          accentColor: Color(0xFFFAC702)),

      home: LoginPage(),
      routes: {
        LoginPage.routeName : (context) => LoginPage(),
        OtpPage.routeName : (context) => OtpPage(),
        ProfilePage.routeName :(context) => ProfilePage()
      },
    );
  }
}
