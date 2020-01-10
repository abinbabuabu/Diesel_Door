import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:petrol_pump/Dataclass.dart';

class FirebaseProvider with ChangeNotifier {
  DatabaseReference _db;
  String sample = "hello";
  FirebaseUser _user;
  bool _isUserAdded = false;
  UserDetails _userData = UserDetails("abin", "smaple", "sample", "India", "");
  bool _orderIsEmpty = false;

  bool get orderIsEmpty => _orderIsEmpty;

  set orderIsEmpty(bool value) {
    _orderIsEmpty = value;
    notifyListeners();
  }

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
      userData = UserDetails.fromSnapshot(result);
      return userData;
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
      "placeId": orderData.placeId,
      "userId":_user.uid
    });
  }

  Future<List<OrderData>> fireRetrieveOrders() async {
    List<OrderData> OrdersList = List();
    _user = await FirebaseAuth.instance.currentUser();
    if (_user != null) {
      var orders = _db.child("Users").child(_user.uid).child("Orders").orderByChild("orderId");
      var result = await orders.once().catchError((error){
        print(error);
      });

      Map<dynamic,dynamic> _resultMap = result.value;

      if(result.value == null){
       orderIsEmpty = true;
      }
      else{
        orderIsEmpty = false;
      }


      _resultMap.forEach((key,value){
        var _orderData = OrderData.fromDynamicMap(value);
        OrdersList.add(_orderData);
      });
      return OrdersList.reversed.toList();
    } else {
      return null;
    }
  }
}
