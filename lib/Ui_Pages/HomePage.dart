import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/Ui_Pages/LoginPage.dart';
import 'package:petrol_pump/small_ui_components/RouteAnimations.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription _streamSubscription;

  Future<FirebaseUser> user;

  @override
  Widget build(BuildContext context) {
    FirebasePhoneAuth.instantiate();
    Timer(Duration(milliseconds: 800), () {
      print("LoginStatus Called");
      checkLoginStatus(_scaffoldKey.currentContext);
    });
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                width: 80,
                height: 80,
                child: Image.asset("assets/logoe.png")),
            SizedBox(height: 30,),
            Text("Diesel Door Delivery",style: TextStyle(fontSize: 20,color: Color(0xFF265FFB)),)
          ],
        ),
      ),
    );
  }

   void checkLoginStatus(BuildContext Navcontext) {
   _streamSubscription = FirebasePhoneAuth.stateStream.listen((state) {
     print("called Stream");
      if (state == PhoneAuthState.Failed) {
       Future.delayed(Duration(seconds: 1),(){
          Navigator.of(_scaffoldKey.currentContext).pushReplacementNamed(LoginPage.routeName);
       });
      }
      if (state == PhoneAuthState.Verified) {
        Future.delayed(Duration(seconds: 1),(){
          Navigator.of(Navcontext)
              .pushReplacementNamed(DetailsPage.routeName);
        });

      }
    });
  }
  @override
  void dispose() {
    _streamSubscription.cancel();
    _streamSubscription =null;
    super.dispose();
  }
}


