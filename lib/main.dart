import 'package:flutter/material.dart';
import 'package:petrol_pump/LoginPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(fontFamily: "Montserrat"),
      home: LoginPage(),
    );
  }
}
