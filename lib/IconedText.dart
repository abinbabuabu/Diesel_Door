import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/HomePage.dart';
import 'package:provider/provider.dart';

import 'LoginProvider.dart';

class IconedText extends StatelessWidget {
  String text;
  var icon;
  bool islogout;

  IconedText({@required this.text,@required this.icon, @required this.islogout});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () {
        },
        child: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: (){
                  print("clicked");
                  if(islogout){
                    Provider.of<LoginProvider>(context).logout().then((value){
                      Navigator.popAndPushNamed(context, HomePage.routeName);
                    });
                  }
                },
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
