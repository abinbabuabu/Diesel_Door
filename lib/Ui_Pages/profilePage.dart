import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/small_ui_components/RoundedTextField.dart';
import 'package:provider/provider.dart';

import '../Providers/LoginProvider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "ProfilePage";
  TextEditingController _nameController = TextEditingController();

  TextEditingController _gstController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _companyController = TextEditingController();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 2.7;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      color: Color(0xFFDEE7FF),
                      width: double.infinity,
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
                  padding: EdgeInsets.only(left: 16, right: 16.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).primaryColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 14),
                      ),
                      RoundedTextField(
                        Icons.person,
                        "Full Name",
                        controller: widget._nameController,
                      ),
                      RoundedTextField(
                        Icons.mail,
                        "Email",
                        controller: widget._emailController,
                      ),
                      RoundedTextField(
                        Icons.domain,
                        "Organisation",
                        controller: widget._companyController,
                      ),
                      RoundedTextField(
                        Icons.info,
                        "Gst No",
                        controller: widget._gstController,
                      ),
                      Container(
                        height: 20,
                      ),
                      ButtonTheme(
                        height: 43,
                        minWidth: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            String name = widget._nameController.text;
                            String gst = widget._gstController.text;
                            String org = widget._companyController.text;
                            String email = widget._emailController.text;
                            var data = _createDataUser(name, org, gst, email);
                            Provider.of<FirebaseProvider>(context)
                                .fireInsertUser(data).then((value){
                                  Navigator.popAndPushNamed(context, DetailsPage.routeName);
                            });

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

  UserDetails _createDataUser(
      String name, String organisation, String gst, String email) {
    var phone = Provider.of<LoginProvider>(context).phoneNumber;
    return UserDetails(name, phone, gst, organisation, email);
  }
}
