
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/Providers/LoginProvider.dart';
import 'package:petrol_pump/small_ui_components/RoundedTextField.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "formProfile",
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 16.0,right: 8.0,left: 8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 25, color: Theme.of(context).primaryColor),
                    ),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 18, bottom: 8),
                  ),
                  MyCustomForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String name, gst, org, email;
  UserDetails _userDetails;

  @override
  Widget build(BuildContext context) {
    _userDetails = Provider.of<FirebaseProvider>(context).userData;
    name = _userDetails.name;
    gst = _userDetails.gst;
    org = _userDetails.organisation;
    email = _userDetails.email;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextField(true,Icons.person, "Fullname", _userDetails.name, (text) {
            name = text;
          }),
          CustomTextField(true,Icons.email, "Email", _userDetails.email, (text) {
            email = text;
          }),
          CustomTextField(true,
              Icons.domain, "Organisation", _userDetails.organisation, (text) {
            org = text;
          }),
          CustomTextField(false,Icons.info, "GST", _userDetails.gst, (text) {
            gst = text;
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ButtonTheme(
              height: 43,
              minWidth: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    _createDataUser(name, org, gst, email).then((data) {
                      Provider.of<FirebaseProvider>(context)
                          .fireInsertUser(data)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    print("${data.name}--- ${data.phone}---$gst---$email");
                    });
                  } else {}
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<UserDetails> _createDataUser(
      String name, String organisation, String gst, String email) async {
    var phone = await FirebaseAuth.instance.currentUser();
    return UserDetails(name, phone.phoneNumber, gst, organisation, email);
  }
}
