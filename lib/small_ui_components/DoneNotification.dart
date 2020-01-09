import 'package:flutter/material.dart';

class NotificationDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        width: 300,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/checked.png",
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Material(
              child: Text(
                "Order Placed Successfully",
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
