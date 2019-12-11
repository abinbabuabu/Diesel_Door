import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconedText extends StatelessWidget {
  String text;
  var icon;

  IconedText({@required this.text,@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
          print("Clicked");
        },
        child: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){},
                splashColor: Colors.blueGrey,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        icon,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(text)
                    ],
                  ),
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(8)),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                height: 3.0,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
