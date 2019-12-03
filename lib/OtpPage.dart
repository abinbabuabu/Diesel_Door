import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/profilePage.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpPage extends StatelessWidget {
  static const routeName = '/otpPage';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 1.5;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      color: Color(0xFFDEE7FF),
                      height: layoutOneHeight,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/building.png',fit: BoxFit.fill,),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 38.0, right: 34.0, top: 16.0),
                  color: Colors.white,
                  height: height - layoutOneHeight,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("OTP Verification",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20)),
                            flex: 4,
                          ),
                          Expanded(
                            child: Text("00.00"),
                            flex: 1,
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: PinPut(
                            fieldsCount: 4,
                            unFocusWhen: false,
                            actionButtonsEnabled: false,
                            onSubmit: null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonTheme(
                          height: 43,
                          minWidth: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              Navigator.pushNamed(context, ProfilePage.routeName);
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
