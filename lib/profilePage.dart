import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_pump/RoundedTextField.dart';


class ProfilePage extends StatelessWidget {
  static const routeName = "ProfilePage";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 2.7;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      color: Color(0xFFDEE7FF),
                      width: double.infinity,
                      height: layoutOneHeight,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/building.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,right: 16.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).primaryColor),
                        ),
                        alignment:Alignment.centerLeft ,
                        margin: EdgeInsets.only(left: 14),
                      ),
                      RoundedTextField(Icons.person,"Full Name"),
                      RoundedTextField(Icons.mail,"Email"),
                      RoundedTextField(Icons.domain,"Organisation"),
                      RoundedTextField(Icons.info,"Gst No"),
                      Container(height: 20,),
                      ButtonTheme(
                        height: 43,
                        minWidth: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {

                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
