import 'package:flutter/material.dart';
import 'package:petrol_pump/HomePage.dart';
import 'package:petrol_pump/LoginPage.dart';
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
      home: HomePage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        ProfilePage.routeName: (context) => ProfilePage()
      },
    );
  }
}
