import 'package:flutter/cupertino.dart';

class CoupledTextOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 16.0),
      child: Column(
        children: <Widget>[
          Text(
            "OrderId",
            style: TextStyle(fontSize: 12,fontFamily: "MontserratLight"),
          ),
          Text("1660302",style: TextStyle(fontSize: 13),)
        ],
      ),
    );
  }
}
