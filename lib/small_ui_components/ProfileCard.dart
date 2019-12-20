import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/small_ui_components/CoupledTextProfile.dart';

class ProfileCard extends StatelessWidget {
  String name;
  String gst;
  String org;
  String email;
  String phone;

  ProfileCard(
      {@required this.name,
      @required this.email,
      @required this.phone,
      @required this.gst,
      @required this.org});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0XFFFFD86A), Color(0XFFFAB700)])),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8.0),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(org),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CoupledTextProfile(
                          label: "EmailId",
                          value: email,
                        ),
                        CoupledTextProfile(
                          label: "Gstno",
                          value: gst,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CoupledTextProfile(
                      label: "Phone Number",
                      value: phone,
                    )
                  ],
                ),
              ),
              flex: 10,
            ),
            Expanded(
              child: Container(
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
