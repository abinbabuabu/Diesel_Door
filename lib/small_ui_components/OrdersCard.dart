import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:petrol_pump/small_ui_components/CoupledTextOrder.dart';

const labelOrderId = "Order Id";
const labelOrderDate = "Order Date";
const labelQuantity = "Quantity";
const labelLocation = "Location";
const labelStatus = "Status";

class OrdersCard extends StatelessWidget {
  String orderId;
  String orderDate;
  String quantity;
  String location;
  String status;
  var color;

  double tagWidth = 6.0;

  OrdersCard(
      {@required this.orderId,
      @required this.orderDate,
      @required this.quantity,
      @required this.location,
      @required this.status});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;

    // ignore: unrelated_type_equality_checks
    if (status.trim().toLowerCase() != "pending")
      color = Colors.green;
    else
      color = Colors.red;

    return Card(
        margin: EdgeInsets.only(left: 8.0,right: 8.0,top:8.0,bottom:8.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0))),
        child: Container(
            height: 100,
            child: Row(children: <Widget>[
              Container(
                width: tagWidth,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                width: widthOfScreen - tagWidth -16,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: CoupledTextOrder(
                                      label: labelOrderId,
                                      value: orderId),
                                  flex: 1,
                                ),

                                Expanded(
                                  child: CoupledTextOrder(
                                    label: labelOrderDate,
                                    value: orderDate,
                                  ),
                                  flex: 1,
                                )
                              ],
                            ),
                            Container(
                              height: 4,
                            ),
                            CoupledTextOrder(
                              label: labelLocation,
                              value: location,
                            )
                          ],
                        ),
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            CoupledTextOrder(
                              label: labelQuantity,
                              value: quantity,
                            ),
                            Container(
                              height: 4,
                            ),
                            CoupledTextOrder(
                              label: labelStatus,
                              value: status,
                              color: color,
                            )
                          ],
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            ])));
  }
}
