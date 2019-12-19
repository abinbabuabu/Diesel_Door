import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;

class MapProvider with ChangeNotifier {
  final geolocator = Geolocator()..forceAndroidLocationManager;
  GoogleMapController _controller;

  String sample = "Testing Map";

  final Set<Marker> _markers = Set();

  Set<Marker> get markers => _markers;

  GoogleMapController get controller => _controller;

  void getLocationPermission() async {
    var location = LocationManager.Location();

    var permission = await location.requestPermission();
    if (permission) {
      print("location Checked ");
      var permission_geo = await geolocator.checkGeolocationPermissionStatus();
      if (permission_geo == GeolocationStatus.granted) {
        print("permission Granted");
        var isGps = await geolocator.isLocationServiceEnabled();
        if (isGps) {
          print("Gps Is ON");
          var position = await geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low);
          print("${position.latitude}${position.longitude}");
          print(position);
          _addMarker(position);
          _cameraMoveMap(position);
        } else {
          print("Gps is OFF");
        }
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_controller != null)
      getLocationPermission();
    else
      print("not Completed");
  }

  void _addMarker(Position position) {
    _markers.clear();
    _markers.add(Marker(
        markerId: MarkerId("Current_Location"),
        position: LatLng(position.latitude, position.longitude)));
    notifyListeners();
  }

  void _cameraMoveMap(Position position) {
    print("inside Camera move");
    if (_controller != null) {
      print("completer Checked ");
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude),zoom: 16)));
    }
  }
}
