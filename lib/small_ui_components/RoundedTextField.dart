import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField(this._iconValue,this._hintText,this.text,{@required this.controller}):super();

  final IconData _iconValue;
  final String _hintText;
  String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    print(text);
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(4.0),
      height: 60,
      width: double.infinity,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: new Icon(_iconValue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: _hintText),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  CustomTextField(this._iconValue,this._hintText,this.text):super();

  final IconData _iconValue;
  final String _hintText;
  String text;
  //final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    print(text);
    return Container(
      margin: EdgeInsets.only(top:8),
      padding: EdgeInsets.all(4.0),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: new Icon(_iconValue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: _hintText),
      ),
    );
  }
}



