import 'package:flutter/cupertino.dart';
import 'package:petrol_pump/DetailsPage.dart';
import 'package:petrol_pump/LoginPage.dart';
import 'package:petrol_pump/LoginProvider.dart';
import 'package:petrol_pump/MapPage.dart';
import 'package:petrol_pump/OtpPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginProvider.instance(),
      child: Consumer(
        // ignore: missing_return
        builder: (context, LoginProvider user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              print("Uninitalised");
              return LoginPage();
            case Status.Unauthenticated:
              print("UnAuthenticated");
              return LoginPage();
            case Status.Authenticated:
              print("Authenticated");
              return DetailsPage();
            case Status.Authenticating:
              print("Athenticating");
              break;
            case Status.PhoneNumberEntered:
              print("Phone Entered");
              return OtpPage();
          }
        },
      ),
    );
  }
}
