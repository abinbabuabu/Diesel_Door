import 'package:flutter/cupertino.dart';
import 'package:petrol_pump/OrdersCard.dart';

class Sample extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OrdersCard(),
        OrdersCard(),
        OrdersCard()
      ],
    );
  }
}

