import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/CoupledTextOrder.dart';

class OrdersCard extends StatelessWidget {
  double tagWidth = 6.0;

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0))),
      child: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Container(
              width: tagWidth,
              color: Colors.blue,
            ),
            Container(
              width: widthOfScreen - tagWidth - 16,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CoupledTextOrder(),
                      CoupledTextOrder(),
                      CoupledTextOrder()
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(child: CoupledTextOrder(),alignment: Alignment.centerLeft,),
                        flex: 2,
                      ),
                      Expanded(
                        child: CoupledTextOrder(),
                        flex: 1,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
