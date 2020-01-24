import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/Ui_Pages/DetailsPage.dart';
import 'package:petrol_pump/small_ui_components/RoundedTextField.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "ProfilePage";
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name,gst,org,email;
  final _formKey = GlobalKey<FormState>();
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
                  child: Form(
                    key:_formKey,
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
                        CustomTextField(
                            1, Icons.person, "Full Name", "", (text) {name=text;}),
                        CustomTextField(
                          2,
                          Icons.mail,
                          "Email",
                          "",
                          (text) {email=text;},
                        ),
                        CustomTextField(
                          1,
                          Icons.domain,
                          "Organisation",
                          "",
                          (text) {org=text;},
                        ),
                        CustomTextField(
                          0,
                          Icons.info,
                          "Gst No",
                          "",
                          (text) {
                            gst=text;
                          },
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

                              if(_formKey.currentState.validate()) {
                                _createDataUser(name, org, gst, email).then((data){
                                  Provider.of<FirebaseProvider>(context)
                                      .fireInsertUser(data)
                                      .then((value) {
                                    Navigator.popAndPushNamed(
                                        context, DetailsPage.routeName);
                                  });
                                });
                              }
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserDetails> _createDataUser  (
      String name, String organisation, String gst, String email) async {
    var phone = await FirebaseAuth.instance.currentUser();
    return UserDetails(name, phone.phoneNumber, gst, organisation, email);
  }
}
