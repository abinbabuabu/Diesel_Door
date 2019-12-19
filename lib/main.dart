import 'package:flutter/material.dart';
import 'package:petrol_pump/DetailsPage.dart';
import 'package:petrol_pump/GooglePlacesProvider.dart';
import 'package:petrol_pump/HomePage.dart';
import 'package:petrol_pump/LoginPage.dart';
import 'package:petrol_pump/profilePage.dart';
import 'package:provider/provider.dart';

import 'FirebaseProvider.dart';
import 'LoginProvider.dart';
import 'MapProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
