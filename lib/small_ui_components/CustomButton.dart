import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomButton(BuildContext _context) {
  BuildContext context = _context;
  return Material(
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      splashColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      child: Container(
        height: 38,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text("Submit",style: TextStyle(color: Colors.white),),
        ),
      ),
    ),
  );
}
