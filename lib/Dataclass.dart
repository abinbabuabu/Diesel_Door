import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PredictionResult{
  String id;
  String name;
  LatLng latLng;
}

class SearchResult {
  String desc;
  String log;
  String lat;

  SearchResult(this.desc, this.log, this.lat);

}


class UserDetails {
  String _name;
  String _organisation;
  String _gst;
  String _phone;
  String _email;

  UserDetails(
      this._name, this._phone, this._gst, this._organisation, this._email);

  String get name => _name;

  String get organisation => _organisation;

  String get gst => _gst;

  String get phone => _phone;

  String get email => _email;

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

  UserDetails.fromSnapshot(DataSnapshot snapshot) {
    _name = snapshot.value["name"];
    _phone = snapshot.value["phone"];
    _gst = snapshot.value["gst"];
    _email = snapshot.value["email"];
    _organisation = snapshot.value["organisation"];
  }
}
