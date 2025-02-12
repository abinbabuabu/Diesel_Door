import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Listeners.dart';

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
  CustomTextField(this._required,this._iconValue,this._hintText,this.text,this.listener):super();

  final IconData _iconValue;
  final String _hintText;
  String text;
  final TextChangeListener listener;
  final int _required;

  @override
  Widget build(BuildContext context) {
    print(text);
    return new Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(1.0),
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        initialValue: text,
        onChanged: (value){
          if(_required==1) {
            if (value.isNotEmpty)
              listener(value);
          }
          else{
            listener(value);
          }
        },
        validator: (value){
          if(_required != 0) {
            if (value.isEmpty) {
              return "Required Field";
            }
            if(_required == 2){
              bool match= RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value);
              if(!match) {
                return "Valid email required";
              }
            }
          }

          return null;
        },
        decoration: InputDecoration(
            prefixIcon: new Icon(_iconValue),
            border: OutlineInputBorder(
              gapPadding: 8,
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: _hintText,
            contentPadding: new EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0)
        ),
      ),
    );
  }
}



