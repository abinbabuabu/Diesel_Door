import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petrol_pump/CustomButton.dart';
import 'package:petrol_pump/RoundButton.dart';
import 'package:petrol_pump/SearchView.dart';

const googleApiKey = "AIzaSyACxC2oh38YG2SxmdMpRPPhpFaWAbP6TyY";

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    print("Map Created");
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
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SearchView(googleApiKey)));
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
                RoundButton(),
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
