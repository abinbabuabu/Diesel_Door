import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/Providers/MapProvider.dart';
import 'package:petrol_pump/small_ui_components/DoneNotification.dart';
import 'package:petrol_pump/small_ui_components/QuantityPicker.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String _orderDate;
  int _quantity = 20;
  bool _connectivity = false;
  StreamSubscription _subscription;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) _connectivity = true;
    });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _connectivity = true;
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _current = DateTime.now();
    _orderDate = _current.day.toString() +
        "-" +
        _current.month.toString() +
        "-" +
        _current.year.toString();
    print(_quantity);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 16.0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text("Order Details",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DatePickerTimeline(
                    DateTime.now(),
                    selectionColor: Theme.of(context).accentColor,
                    onDateChange: (date) {
                      _orderDate = date.day.toString() +
                          "-" +
                          date.month.toString() +
                          "-" +
                          date.year.toString();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Quantity(In Liters)",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: NumberPicker.integer(
                          initialValue: _quantity,
                          minValue: 20,
                          maxValue: 500,
                          onChanged: (value) =>setState(()=> _quantity = value))
                          ),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      EdgeInsets.only(right: 16.0, left: 16.0, bottom: 32.0),
                  child: ButtonTheme(
                    height: 43,
                    padding: EdgeInsets.only(right: 16.0, left: 16.0),
                    minWidth: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        if (_connectivity) {
                          uploadAndDisplayDialog(context);
                        } else {
                          _displaySnackBar(context, "No Internet Connection");
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _displaySnackBar(BuildContext context, String text) {
    FocusScope.of(context).unfocus();
    final snackbar = SnackBar(
      content: Text(text),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void uploadAndDisplayDialog(BuildContext context) {
    var Fireprovider = Provider.of<FirebaseProvider>(context);
    var mapProvider = Provider.of<MapProvider>(context);

    var orderData = mapProvider.orderData;
    orderData.orderId = DateTime.now().millisecondsSinceEpoch.toString();
    orderData.orderDate = _orderDate.toString();
    orderData.quantity = _quantity.toString();

    if (orderData.formattedAddress != null ||
        orderData.formattedAddress.length > 2) {
      Fireprovider.fireInsertOrder(orderData).then((value) {
        showDialog(
          context: context,
          child: NotificationDone(),
          barrierDismissible: true,
        ).then((value) {
          Navigator.of(context).pop();
        });
      });
    } else {
      _displaySnackBar(context, "Error ! try again");
    }
  }
}
