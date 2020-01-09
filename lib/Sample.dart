import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/small_ui_components/OrdersCard.dart';
import 'package:provider/provider.dart';

class Sample extends StatefulWidget {
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FirebaseProvider>(context);
    return FutureBuilder(
        future: provider.fireRetrieveOrders(),
        builder: (context, snap) {
          if (snap.hasData) {
            return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, index) {
                  OrderData v = snap.data[index];
                  return OrdersCard(
                    orderDate: v.orderDate,
                    orderId: v.orderId,
                    location: v.formattedAddress,
                    status: v.status,
                    quantity: v.quantity,
                  );
                });
          } else {
            return LinearProgressIndicator();
          }
        });
  }

  Widget _choose(AsyncSnapshot snap) {
    bool f = true;
    Timer(Duration(seconds: 1), () {
      if (!snap.hasData) {
        setState(() {
          f=false;
        });

      }
    });
    if (f) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
      ));
    } else
      return Text("No data");
  }
}
