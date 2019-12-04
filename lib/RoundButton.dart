import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 8.0,
          child: Icon(Icons.my_location), onPressed: () {},
        ),
      ),
    );
  }

}
