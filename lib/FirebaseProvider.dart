import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'UserDetails.dart';

class FirebaseProvider with ChangeNotifier {
  DatabaseReference _db;
  FirebaseUser _user;

  FirebaseProvider.instance() : _db = FirebaseDatabase.instance.reference() {
    FirebaseAuth.instance.currentUser().then((user) {
      _user = user;
      _db.child(_user.uid);
    });
  }

  void fireInsertUser(UserDetails user) {
    print("Called");
    print(user.phone);
    _db.child("UserDetails").push().set(<String, String>{
      "name": user.name,
      "organisation": user.organisation,
      "phone": user.phone,
      "email": user.email,
      "gst": user.gst
    });
  }

  void fireDelete() {}

  UserDetails fireRetrieveUserDetails() {
    var UserDetails =_db.child("UserDetails");
    if(UserDetails!=null){
      var snapShot = UserDetails.onValue;
      print(snapShot.toString());
    }
  }
}
