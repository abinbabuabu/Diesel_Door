import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  static const routeName = '/otpPage';
  String clock = "00:00";

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _otp;
  Timer _time;

  void timer(Timer value) {
    var time = value.tick;
    if (mounted) {
      widget.clock = "00:$time";
      if (time > 58) {
        value.cancel();
        widget.clock = "";
      }
      if (time < 10) {
        widget.clock = "00:0$time";
      }
      setState(() {
        widget.clock;
      });
    } else {
      value.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _time = Timer.periodic(Duration(milliseconds: 1000), timer);
    }
  }

  @override
  void dispose() {
    _time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginProvider>(context);
    var auth = provider.auth;
    var phoneNumber = provider.phoneNumber;

    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 20),
        verificationCompleted: provider.verificationCompleted,
        verificationFailed: provider.verificationFailed,
        codeSent: provider.codeSent,
        codeAutoRetrievalTimeout: provider.codeAutoRetrievalTimeout);
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
                        child: Image.asset(
                          'assets/building.png',
                          fit: BoxFit.fill,
                        ),
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
                            child: Text(widget.clock),
                            flex: 1,
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          child: PinPut(
                            fieldsCount: 6,
                            unFocusWhen: false,
                            actionButtonsEnabled: false,
                            onSubmit: (number) {
                              _otp = number;
                              provider.SignInWithPhoneNumber(_otp);
                            },
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
                              provider.SignInWithPhoneNumber(_otp);
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
