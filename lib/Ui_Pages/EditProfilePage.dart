import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/small_ui_components/RoundedTextField.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  static const routeName = "ProfilePage";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double layoutOneHeight = height / 2.7;
    //UserDetails _userData = Provider.of<FirebaseProvider>(context).userData;
    String name, gst, org, email;
    final _key = GlobalKey<FormState>();
    print("Caled");
    return Scaffold(
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
                Form(
                    key: _key,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            initialValue: "hello",
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ])),
                Container(
                  height: 20,
                ),
                ButtonTheme(
                  height: 43,
                  minWidth: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
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
    );
}



  Future<UserDetails> createDataUser(
      String name, String organisation, String gst, String email) async {
    var phone = await FirebaseAuth.instance.currentUser();
    return UserDetails(name, phone.phoneNumber, gst, organisation, email);
  }
}
