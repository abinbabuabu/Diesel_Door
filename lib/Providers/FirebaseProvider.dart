import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Ui_Pages/OrderPage.dart';

class FirebaseProvider with ChangeNotifier {
  DatabaseReference _db;
  String sample = "hello";
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
    _db
        .child("Users")
        .child(_user.uid)
        .child("UserDetails")
        .set(<String, String>{
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
      var _userDetails =
          _db.child("Users").child(user.uid).child("UserDetails");
      var result = await _userDetails.once();
      var _userdata = UserDetails.fromSnapshot(result);
      return _userdata;
    } else {
      return null;
    }
  }

  Future<void> fireInsertOrder(OrderData orderData) async {
    _user = await FirebaseAuth.instance.currentUser();
    _db
        .child("Users")
        .child(_user.uid)
        .child("Orders")
        .push()
        .set(<String, String>{
      "orderId": orderData.orderId,
      "orderDate": orderData.orderDate,
      "status": orderData.status,
      "quantity": orderData.quantity,
      "locationName": orderData.name,
      "locality": orderData.locality,
      "latLng": orderData.latLng,
      "formattedAddress": orderData.formattedAddress,
      "placeId": orderData.placeId
    });

    _db.child("Orders").push().set(<String, String>{
      "orderId": orderData.orderId,
      "orderDate": orderData.orderDate,
      "status": orderData.status,
      "quantity": orderData.quantity,
      "locationName": orderData.name,
      "locality": orderData.locality,
      "latLng": orderData.latLng,
      "formattedAddress": orderData.formattedAddress,
      "placeId": orderData.placeId
    });
  }

  Future<List<OrderData>> fireRetrieveOrders() async {
    List<OrderData> OrdersList = List();
    _user = await FirebaseAuth.instance.currentUser();
    if (_user != null) {
      var orders = _db.child("Users").child(_user.uid).child("Orders").orderByChild("orderId");
      var result = await orders.once();

      Map<dynamic,dynamic> _resultMap = result.value;

      _resultMap.forEach((key,value){
        var _orderData = OrderData.fromDynamicMap(value);
        OrdersList.add(_orderData);
      });
      return OrdersList;
    } else {
      return null;
    }
  }
}
