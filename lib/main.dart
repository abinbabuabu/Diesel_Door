import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petrol_pump/Providers/GooglePlacesProvider.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/Ui_Pages/EditProfilePage.dart';
import 'package:petrol_pump/Ui_Pages/HomePage.dart';
import 'package:petrol_pump/Ui_Pages/LoginPage.dart';
import 'package:petrol_pump/Ui_Pages/profilePage.dart';
import 'package:provider/provider.dart';

import 'Providers/FirebaseProvider.dart';
import 'Providers/LoginProvider.dart';
import 'Providers/MapProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark

    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider.instance(),
        ),
        ChangeNotifierProvider<FirebaseProvider>(
          create: (_) => FirebaseProvider.instance(),
        ),
        ChangeNotifierProvider<MapProvider>(
          create: (_) => MapProvider(),
        ),
        ChangeNotifierProvider<PlacesProvider>(
          create: (_) => PlacesProvider.instance(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Montserrat",
            primaryColor: Color(0xFF265FFB),
            accentColor: Color(0xFFFAC702)),
        home: HomePage(),
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          ProfilePage.routeName: (context) => ProfilePage(),
          DetailsPage.routeName: (context) => DetailsPage(),
          HomePage.routeName: (context) => HomePage()
        },
      ),
    );
  }
}
//
