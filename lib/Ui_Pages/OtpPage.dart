import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/Ui_Pages/HomePage.dart';
import 'package:petrol_pump/Ui_Pages/LoginPage.dart';
import 'package:petrol_pump/Ui_Pages/UILoading.dart';
import 'package:petrol_pump/Ui_Pages/profilePage.dart';
import 'package:pinput/pin_put/pin_put.dart';


class OtpPage extends StatefulWidget {
  static const routeName = '/otpPage';
  String clock = "00:00";

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _otp;
  Timer _time;
  bool _connectivity = false;
  StreamSubscription _subscription;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    autoCodeRetrieve();
    if (mounted) {
      _time = Timer.periodic(Duration(milliseconds: 1000), timer);
    }

    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) _connectivity = true;
    });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _connectivity = true;
      }
    });
  }

  @override
  void dispose() {
    _time.cancel();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build Called");
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 1.5;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top:50),
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
                            autoFocus: true,
                            keyboardType: TextInputType.number,
                            keyboardAction: TextInputAction.done,
                            fieldsCount: 6,
                            unFocusWhen: false,
                            actionButtonsEnabled: false,
                            onSubmit: (number) {
                              _otp = number;
                              signInWithSms(_otp);
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
                              if (_connectivity) {
                                _time.cancel();
                                widget.clock = "";
                                signInWithSms(_otp);
                              } else {
                                _displaySnackBar(
                                    context, "No Internet Connection");
                              }
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

  void _displaySnackBar(BuildContext context, String text) {
    FocusScope.of(context).unfocus();
    final snackbar = SnackBar(
      content: Text(text),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  autoCodeRetrieve() {
    FirebasePhoneAuth.stateStream.listen((state) {
      if (state == PhoneAuthState.Verified) {
        FocusScope.of(context).unfocus();
          Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed(UILoading.routeName);
      }
      else if (state == PhoneAuthState.newUser) {
        Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed(ProfilePage.routeName);
      }
      else{
        _displaySnackBar(context, "Login failed!  Try again later ");
        Future.delayed(Duration(seconds: 8),(){
          Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed(HomePage.routeName);
        }) ;
      }
    });
  }
}

signInWithSms(String sms) {
  FirebasePhoneAuth.signInWithPhoneNumber(sms);
}
