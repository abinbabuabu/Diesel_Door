import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'UserDetails.dart';

class FirebaseProvider with ChangeNotifier {
  DatabaseReference _db;
  FirebaseUser _user;
  bool _isUserAdded = false;
  UserDetails _userData = UserDetails("abin", "smaple", "sample", "India", "");

  set userData(UserDetails newValue) {
    _userData = newValue;
    notifyListeners();
  }

  UserDetails get userData => _userData;

  set isUserAdded(bool newValue) {
    _isUserAdded = newValue;
  }

  bool get isUserAdded => _isUserAdded;

  FirebaseProvider.instance() : _db = FirebaseDatabase.instance.reference();

  Future<bool> fireInsertUser(UserDetails user) async {
    _user = await FirebaseAuth.instance.currentUser();
    print("Called");
    print(user.phone);
    _db.child(_user.uid).child("UserDetails").set(<String, String>{
      "name": user.name,
      "organisation": user.organisation,
      "phone": user.phone,
      "email": user.email,
      "gst": user.gst
    }).then((value) {
      return true;
    });
  }

  void fireDelete() {}

  Future<UserDetails> fireRetrieveUserDetails() async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      var _userDetails = _db.child(user.uid).child("UserDetails");
      var result = await _userDetails.once();
      var _userdata = UserDetails.fromSnapshot(result);
      return _userdata;
    } else {
      return null;
    }
  }

}
