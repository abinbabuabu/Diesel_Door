import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'UserDetails.dart';

class FirebaseProvider with ChangeNotifier {
  DatabaseReference _db;
  FirebaseUser _user;
  bool _isUserAdded = false;
  UserDetails _userData = null;

  set userData(UserDetails newValue){
    _userData = newValue;
  }

  UserDetails get userData => _userData;


  set isUserAdded(bool newValue) {
    _isUserAdded = newValue;
  }

  bool get isUserAdded => _isUserAdded;

  FirebaseProvider.instance() : _db = FirebaseDatabase.instance.reference() ;

  Future<bool> fireInsertUser(UserDetails user) async {
   _user = await FirebaseAuth.instance.currentUser();
    print("Called");
    print(user.phone);
    _db.child(_user.uid).child("UserDetails").push().set(<String, String>{
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
     FirebaseAuth.instance.currentUser().then((value){
       if(value == null)
         print("User value is null");
       print(value.uid);
     });
    print("called Retrieve UserDetails ");
    var _userDetails = _db.child(_user.uid).child("UserDetails");
    var snapShot = await _userDetails.once();
    var result = snapShot.value as Map<dynamic, dynamic>;
    print(result);
    result.forEach((key, value) {
      userData = UserDetails.fromDb(value);
    });
    return userData;
  }
}
