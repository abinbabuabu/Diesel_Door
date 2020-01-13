import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/Ui_Pages/MapPage.dart';
import 'package:petrol_pump/Ui_Pages/OrdersPage.dart';
import 'package:petrol_pump/Ui_Pages/PersonalisePage.dart';


class DetailsPage extends StatefulWidget {
  static const routeName = "DetailsPage";
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MapPage(),
    OrdersPage(),
    PersonalisePage()
  ];

  void _onTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    FirebasePhoneAuth.onAuthenticationSuccessful();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(child: _children[_currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  title: Text("Orders")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile")
              )
            ],
            onTap: _onTapped,
          ),
        );

  }
}
