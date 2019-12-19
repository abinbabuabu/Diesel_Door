import 'package:flutter/cupertino.dart';
import 'package:petrol_pump/DetailsPage.dart';
import 'package:petrol_pump/FirebaseProvider.dart';
import 'package:petrol_pump/LoginPage.dart';
import 'package:petrol_pump/LoginProvider.dart';
import 'package:petrol_pump/MapPage.dart';
import 'package:petrol_pump/MapProvider.dart';
import 'package:petrol_pump/OtpPage.dart';
import 'package:petrol_pump/profilePage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homePage';
  @override
  Widget build(BuildContext context) {
    Widget _child;
    var login = Provider.of<LoginProvider>(context);
    switch (login.status) {
      case Status.Uninitialized:
        print("Uninitalised");
        _child = LoginPage();
        break;
      case Status.Unauthenticated:
        print("UnAuthenticated");
        _child = LoginPage();
        break;
      case Status.Authenticated:
        print("Authenticated");
        _child = DetailsPage();
        break;
      case Status.Authenticating:
        print("Athenticating");
        break;
      case Status.PhoneNumberEntered:
        print("Phone Entered");
        _child = OtpPage();
        break;
      case Status.AuthenticatedNewUser:
        print("new User");
        _child = ProfilePage();
        break;
    }
    return _child;
  }
}
