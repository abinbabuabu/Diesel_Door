import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Providers/FirebaseProvider.dart';
import 'package:petrol_pump/small_ui_components/IconedText.dart';
import 'package:petrol_pump/small_ui_components/ProfileCard.dart';
import 'package:petrol_pump/small_ui_components/loadingCardProfile.dart';
import 'package:provider/provider.dart';

class PersonalisePage extends StatefulWidget {
  @override
  _PersonalisePageState createState() => _PersonalisePageState();
}

class _PersonalisePageState extends State<PersonalisePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FirebaseProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 8.0, left: 8.0, top: 16.0),
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
              FutureBuilder(
                future: provider.fireRetrieveUserDetails(),
                builder: (BuildContext context,
                    AsyncSnapshot<UserDetails> snapshot) {
                  if (snapshot.hasData) {
                    var details = snapshot.data;
                    return ProfileCard(
                      name: details.name,
                      email: details.email,
                      phone: details.phone,
                      gst: details.gst,
                      org: details.organisation,
                    );
                  } else {
//                    return ProfileCard(
////                        name: "", gst: "", org: "", email: "", phone: "");
                    return LoadingCard();
                  }
                },
              ),
              SizedBox(height: 100),
              IconedText(
                icon: Icons.contact_mail,
                text: "My Addresses",
                islogout: false,
              ),
              IconedText(
                icon: Icons.arrow_back,
                text: "Logout",
                islogout: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
