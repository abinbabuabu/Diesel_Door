

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class UserDetails{
  String _name;
  String _organisation;
  String _gst;
  String _phone;
  String _email;

  UserDetails(this._name,this._phone,this._gst,this._organisation,this._email);

  String get name => _name;
  String get organisation => _organisation;
  String get gst => _gst;
  String get phone => _phone;
  String get email => _email;

  UserDetails.fromDb(DataSnapshot data){
    var _data = data.value;
    _name = _data['name'];
    _organisation = _data['organisation'];
    _gst = _data['gst'];
    _phone = _data['phone'];
    _email = _data['email'];
  }
}