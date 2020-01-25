import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/Ui_Pages/OtpPage.dart';
import 'package:petrol_pump/small_ui_components/RouteAnimations.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phone;
  StreamSubscription _subscription;
  bool _connectivity = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _visibility = true;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(toggleContainerVisibility);

    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) _connectivity = true;
    });
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) _connectivity = true;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void toggleContainerVisibility() {
    _visibility = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 1.5;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: _visibility,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Color(0xFFDEE7FF),
                        padding: EdgeInsets.only(top: 50),
                        margin: EdgeInsets.only(bottom: 8.0),
                        height: layoutOneHeight,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Image.asset('assets/loginImage.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Welcome to ",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Text(
                              "Diesel Door Delivery",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
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
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 16.0),
                  height: (height - layoutOneHeight),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 38.0, top: 2.0, right: 38.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 22),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 4.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0, bottom: 30.0,right: 2.0,left: 2.0),
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value){
                              if(value.length != 10){
                                return "Invalid mobile number ";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.send,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixText: "+91 ",
                                border: OutlineInputBorder(
                                  gapPadding:8 ,
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: new EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
                                hintText: "Phone Number"),
                            focusNode: _focusNode,
                            onChanged: (text) {
                              phone = text;
                            },
                          ),
                        ),
                      ),
                      ButtonTheme(
                        height: 43,
                        minWidth: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            print(_connectivity.toString());
                            if (_formKey.currentState.validate()) {
                              if (_connectivity) {
                                 startPhoneAuth(phone,context);
                              } else {
                                _displaySnackBar(context);
                                print("No internet");
                              }
                            }
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

  void _displaySnackBar(BuildContext context) {
    FocusScope.of(context).unfocus();
    final snackbar = SnackBar(
      content: Text("No Internet Connection"),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  startPhoneAuth(String phone,BuildContext navcontext) {
    if (_connectivity) {
      FirebasePhoneAuth.startAuth(phoneNumber: "+91" + phone);
      FirebasePhoneAuth.stateStream.listen((state) {
        if (state == PhoneAuthState.CodeSent) {
          Navigator.of(_scaffoldKey.currentContext).pushReplacement(
              SlideRightRoute(page: OtpPage()));
        }
        if (state == PhoneAuthState.Failed)
          debugPrint("Seems there is an issue with it");
      });
    }
  }
}

class LoginArguments {
  final String phoneNumber;

  LoginArguments(this.phoneNumber);
}
