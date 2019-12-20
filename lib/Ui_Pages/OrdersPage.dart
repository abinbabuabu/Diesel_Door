import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Sample.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Orders",
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Sample(),
        ),
      ),
    );
  }
}
