import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:petrol_pump/RoundButton.dart';
import 'package:petrol_pump/SearchView.dart';

const googleApiKey = "AIzaSyACxC2oh38YG2SxmdMpRPPhpFaWAbP6TyY";

class MapPage extends StatefulWidget {
  Future<GeolocationStatus> geolocationStatus;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController controller;
  static const LatLng _center = const LatLng(55.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    controller = controller;
    print("Map Created");
  }

  Future<GeolocationStatus> _getLocationPermission() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    return geolocationStatus;
  }

  Future<Position> _getLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print("Latitude: ${position.latitude}, Logitude ${position.longitude}");
    print("Clicked Fab");
    return position;
  }

  @override
  void initState() {
    widget.geolocationStatus = _getLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _enabled = false;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _center, zoom: 11.0),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchView(googleApiKey)));
                });
              },
              child: AbsorbPointer(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 34, right: 16, left: 16),
                    padding: EdgeInsets.all(4.0),
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      onTap: () {},
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.grey)),
                          filled: true,
                          enabled: false,
                          fillColor: Colors.white,
                          hintText: "Search"),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      elevation: 8.0,
                      child: Icon(Icons.my_location),
                      onPressed: () {
                        _getLocationPermission();
                        var position = _getLocation();
                        setState(() {
                          position.then((value) {
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: LatLng(
                                        value.latitude, value.longitude))));
                          });
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonTheme(
                      height: 43,
                      minWidth: MediaQuery.of(context).size.width - 30,
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {},
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
