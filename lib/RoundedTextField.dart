import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField(this.iconValue,this.hintText):super();

  final IconData iconValue;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(4.0),
      height: 60,
      width: double.infinity,
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: new Icon(iconValue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: hintText),
      ),
    );
  }
}
