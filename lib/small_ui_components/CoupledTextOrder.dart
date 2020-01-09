import 'package:flutter/cupertino.dart';

class CoupledTextOrder extends StatelessWidget {
  String label;
  String value;
  var color;

  CoupledTextOrder({@required this.label, @required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            child: Text(
              label,
              softWrap: true,
              style: TextStyle(fontSize: 12, fontFamily: "MontserratLight"),
            ),
            alignment: Alignment.centerLeft,
          ),
          Align(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: TextStyle(fontSize: 13, color: color),
            ),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
    );
  }
}
