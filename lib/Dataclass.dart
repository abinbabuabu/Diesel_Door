import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Isn't it the same as Search Result ?

class PredictionResult {
  String id;
  String name;
  LatLng latLng;
  bool iconVisibility = true;
}

// The search  retrieved from the google Maps

class SearchResult {
  String desc;
  String log;
  String lat;

  SearchResult(this.desc, this.log, this.lat);
}

// User Details Data class used for uploading and retrieve the data from the firebase

class UserDetails {
  String _name="";
  String _organisation="";
  String _gst="";
  String _phone="";
  String _email="";

  UserDetails(
      this._name, this._phone, this._gst, this._organisation, this._email);

  String get name => _name;

  String get organisation => _organisation;

  String get gst => _gst;

  String get phone => _phone;

  String get email => _email;

  // This is not Used remove if not used !

  UserDetails.fromDb(Map<dynamic, dynamic> data) {
    data.forEach((key, value) {
      switch (key.trim()) {
        case "phone":
          _phone = value;
          break;
        case "name":
          _name = value;
          break;
        case "organisation":
          _organisation = value;
          break;
        case "email":
          _email = value;
          break;
        case "gst":
          _gst = value;
          break;
      }
    });
  }

  // This is Used to serialize the data retrieved from the Firebase Realtime database

  UserDetails.fromSnapshot(DataSnapshot snapshot) {
    _name = snapshot.value["name"];
    _phone = snapshot.value["phone"];
    _gst = snapshot.value["gst"];
    _email = snapshot.value["email"];
    _organisation = snapshot.value["organisation"];
  }
}

// Not used remove !

class Clock {
  int minute = 0;
  int seconds = 0;
  int count = 0;

  increment() {
    if (count > 60) {
      count = 0;
      minute++;
      seconds = 0;
    } else {
      seconds++;
      count++;
    }
  }
}

class LocationResult {
  String name;
  String locality;
  String latlng;
  String formattedAddress;
  String placeId;
}

class OrderData {
  String orderId;
  String orderDate;
  String status = "Pending";
  String quantity;
  String name = "";
  String locality = "";
  String latLng = "";
  String formattedAddress;
  String placeId = "";
  String userID ="";

  OrderData.fromSnapshot(DataSnapshot snapshot) {
    orderId = snapshot.value["orderId"];
    orderDate = snapshot.value["orderDate"];
    status = snapshot.value["status"];
    quantity = snapshot.value["quantity"];
    formattedAddress = snapshot.value["formattedAddress"];
  }
  OrderData();

  OrderData.fromDynamicMap(Map<dynamic,dynamic> map){
   orderId = map["orderId"];
   orderDate = map["orderDate"];
   status =  map["status"];
   quantity = map["quantity"];
   formattedAddress =  map["formattedAddress"];
  }

}

enum TextType{email,required,notrequired}
