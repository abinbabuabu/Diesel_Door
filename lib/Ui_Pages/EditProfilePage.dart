import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/small_ui_components/RoundedTextField.dart';
import 'package:provider/provider.dart';

import '../Providers/LoginProvider.dart';

class EditProfile extends StatefulWidget {
  static const routeName = "ProfilePage";
  TextEditingController _nameController = TextEditingController();

  TextEditingController _gstController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _companyController = TextEditingController();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 2.7;
    UserDetails _userData = Provider.of<FirebaseProvider>(context).userData;
    return Hero(
      tag: "editprofile",
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 32),
              padding: EdgeInsets.only(left: 16, right: 16.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 25, color: Theme.of(context).primaryColor),
                    ),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 14),
                  ),
                  RoundedTextField(
                    Icons.person,
                    "Full Name",
                    _userData.name,
                    controller: widget._nameController,
                  ),
                  RoundedTextField(
                    Icons.mail,
                    "Email",
                    _userData.email,
                    controller: widget._emailController,
                  ),
                  RoundedTextField(
                    Icons.domain,
                    "Organisation",
                    _userData.organisation,
                    controller: widget._companyController,
                  ),
                  RoundedTextField(
                    Icons.info,
                    "Gst No",
                    _userData.gst,
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
                        createDataUser(name, org, gst, email).then((value) {
                          Provider.of<FirebaseProvider>(context)
                              .fireInsertUser(value)
                              .then((value) {
                            Navigator.pop(context);
                          });
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
            ),
          ),
        ),
      ),
    );
  }

  Future<UserDetails> createDataUser(
      String name, String organisation, String gst, String email) async {
    var phone = await FirebaseAuth.instance.currentUser();
    return UserDetails(name, phone.phoneNumber, gst, organisation, email);
  }
}
