import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/IconedText.dart';
import 'package:petrol_pump/ProfileCard.dart';

class PersonalisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 8.0, left: 8.0,top: 16.0),
          child: Column(
            children: <Widget>[
              Center(
                  child: Text(
                "Profile",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
              )),
              SizedBox(
                height: 8,
              ),
              ProfileCard(),
              SizedBox(height:100),
              IconedText(icon: Icons.contact_mail,text: "My Addresses",),
              IconedText(icon:Icons.arrow_back ,text:"Logout",)
            ],
          ),
        ),
      ),
    );
  }
}
