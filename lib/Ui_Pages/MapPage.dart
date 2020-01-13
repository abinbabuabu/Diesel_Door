import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petrol_pump/CustomSearch.dart';
import 'package:petrol_pump/Dataclass.dart';
import 'package:petrol_pump/Ui_Pages/AddOrderPage.dart';
import 'package:petrol_pump/small_ui_components/RouteAnimations.dart';
import 'package:provider/provider.dart';

import '../Providers/MapProvider.dart';

const googleApiKey = "AIzaSyDmFsYarIa5yJppIMjJ0zph2e3X8bWI0tA";

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _center = const LatLng(55.521563, -122.677433);
  PredictionResult clickedResult;
  StreamSubscription _subscription;
  bool _connectivity = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Connectivity().checkConnectivity().then((value) {
      if (value == ConnectivityResult.mobile ||
          value == ConnectivityResult.wifi) _connectivity = true;
    });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _connectivity = true;
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MapProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              onMapCreated: provider.onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _center, zoom: 11.0),
              markers: provider.markers,
              onTap: (latLng) {
                provider.moveToLocation(latLng);
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 34, right: 16, left: 16),
                padding: EdgeInsets.all(4.0),
                height: 60,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    var result =
                        showSearch(context: context, delegate: CustomSearch());
                    result.then((value) {
                      for (var i in value) {
                        clickedResult = i;
                      }
                      provider.moveToLocation(clickedResult.latLng);
                    });
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      autofocus: false,
                      onTap: () {},
                      style: TextStyle(fontSize: 14.0),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(color: Colors.white30)),
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
                        if(!provider.isGps){
                          _displaySnackBar(context,"Turn on Gps");
                        }
                        provider.getLocationPermission();
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
                        onPressed: () {
                          if (_connectivity) {
                            Navigator.of(context)
                                .push(SlideRightRoute(page: OrderPage()));
                            provider
                                .reverseGeocodeLatLng(provider.lastLocation);
                          } else {
                            _displaySnackBar(context,"No Internet Connection");
                          }
                        },
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

  void _displaySnackBar(BuildContext context,String text) {
    FocusScope.of(context).unfocus();
    final snackbar = SnackBar(
      content:  Text(text),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

}
