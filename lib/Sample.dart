import 'package:flutter/cupertino.dart';
import 'package:petrol_pump/small_ui_components/OrdersCard.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OrdersCard(
          orderId: "1660302",
          orderDate: "28-12-1998",
          status: "Pending",
          location: "Christ Faculty of Engineering",
          quantity: "121L",
        ),
        OrdersCard(
          orderId: "1660302",
          orderDate: "28-12-1998",
          status: "Pending",
          location: "Christ Faculty of Engineering",
          quantity: "121L",
        ),
        OrdersCard(
          orderId: "1660302",
          orderDate: "28-12-1998",
          status: "Pending",
          location: "Christ Faculty of Engineering",
          quantity: "121L",
        ),
        OrdersCard(
          orderId: "1660302",
          orderDate: "28-12-1998",
          status: "Completed",
          location: "Christ Faculty of Engineering",
          quantity: "121L",
        ),
      ],
    );
  }
}
