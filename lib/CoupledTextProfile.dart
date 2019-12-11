import 'package:flutter/cupertino.dart';

class CoupledTextProfile extends StatelessWidget {
  String label;
  String value;
  var color;

  CoupledTextProfile({@required this.label, @required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            child: Text(
              label.toUpperCase(),
              softWrap: true,
              style: TextStyle(fontSize: 11, fontFamily: "MontserratLight"),
            ),
            alignment: Alignment.centerLeft,
          ),
          Align(
            child: Text(
              value,
              softWrap: true,
              style: TextStyle(fontSize: 13, color: color),
            ),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
    );
  }
}