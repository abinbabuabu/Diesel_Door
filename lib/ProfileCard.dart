import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/CoupledTextProfile.dart';

class ProfileCard extends StatelessWidget {
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
                      "Abin Babu",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text("Emilda Solutions Private Limited"),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CoupledTextProfile(
                          label: "EmailId",
                          value: "abinbabuabk@gmail.com",
                        ),
                        CoupledTextProfile(
                          label: "Gstno",
                          value: "3AAAX453232TN",
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CoupledTextProfile(
                      label: "Phone Number",
                      value: "9656795221",
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
