import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/Ui_Pages/LoginPage.dart';
import 'package:petrol_pump/small_ui_components/RouteAnimations.dart';

class HomePage extends StatelessWidget {
  Future<FirebaseUser> user;
  static const routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    FirebasePhoneAuth.instantiate();
    Timer(Duration(seconds: 2), () {
      checkLoginStatus(context);
    });
    return Container(
      child: Center(
        child: Text("Welcome"),
      ),
    );
  }

  checkLoginStatus(BuildContext context) {
    FirebasePhoneAuth.stateStream.listen((state) {
      SchedulerBinding.instance.addPostFrameCallback((_){

      });
      if (state == PhoneAuthState.Failed) {
        Navigator.of(context)
            .pushReplacement(SlideRightRoute(page: LoginPage()));
      }
      if (state == PhoneAuthState.Verified) {
        SchedulerBinding.instance.addPostFrameCallback((_){});
        Navigator.of(context)
            .pushReplacement(SlideRightRoute(page: DetailsPage()));
      }
    });
  }
}
