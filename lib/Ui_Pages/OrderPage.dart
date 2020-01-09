import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/Providers/MapProvider.dart';
import 'package:petrol_pump/small_ui_components/DoneNotification.dart';
import 'package:petrol_pump/small_ui_components/QuantityPicker.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  String _orderDate;
  int _quantity;

  @override
  Widget build(BuildContext context) {
    var _current = DateTime.now();
    _orderDate = _current.day.toString() +
        "-" +
        _current.month.toString() +
        "-" +
        _current.year.toString();
    _quantity = 20;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Quantity",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Counter(
                        minValue: 20,
                        initialValue: 20,
                        maxValue: 2000,
                        onChanged: (value) {
                          _quantity = value;
                        },
                      ),
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
                          var Fireprovider =
                              Provider.of<FirebaseProvider>(context);
                          var mapProvider = Provider.of<MapProvider>(context);

                          var orderData = mapProvider.orderData;
                          orderData.orderId =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          orderData.orderDate = _orderDate.toString();
                          orderData.quantity = _quantity.toString();

                          Fireprovider.fireInsertOrder(orderData).then((value) {
                            showDialog(
                              context: context,
                              child: NotificationDone(),
                              barrierDismissible: true,
                            ).then((value) {
                              Navigator.of(context).pop();
                            });
                          });
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
      ),
    );
  }
}
