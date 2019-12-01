import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {

  RoundedTextField(this._focusNode):super();
  FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      height: 60,
      width: 300,
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                  color: Colors.red
              ),
            ),
            hintText: "Phone Number"),
        focusNode: _focusNode,
      ),
    );
  }
}
