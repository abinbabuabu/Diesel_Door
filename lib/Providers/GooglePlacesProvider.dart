import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:petrol_pump/Dataclass.dart';
import 'package:uuid/uuid.dart';

const googleApiKey = "AIzaSyDmFsYarIa5yJppIMjJ0zph2e3X8bWI0tA";

class PlacesProvider with ChangeNotifier {
  GoogleMapsPlaces _places;
  String sessionToken = Uuid().v4();

  PlacesProvider.instance()
      : _places = new GoogleMapsPlaces(apiKey: googleApiKey);

  Future<List<SearchResult>> autoCompleteSearch(String text) async {
    List<SearchResult> result = List();
    PlacesAutocompleteResponse response = await _places.autocomplete(text);
    if (response.isOkay) {
      for (var i in response.predictions) {
        var geometry = findPlaceID(i.placeId);
        geometry.then((value) {
          var location = value.result.geometry.location;
          print(location.lat.toString() + " : " + location.lng.toString());
          var _searchResult = SearchResult(
              i.description, location.lat.toString(), location.lng.toString());
          result.add(_searchResult);
        });
      }
    }
    return result;
  }

  Future<PlacesDetailsResponse> findPlaceID(String placeid) async {
    List<String> fieldList = ["geometry"];
    var response;
    _places.getDetailsByPlaceId(placeid).then((value) {
      if (value.isOkay) {
        print("value Is okey");
        response = value;
        print(value.result.formattedAddress);
      } else {
        print(value.errorMessage);
      }
    });
    return response;
  }

  Future<List<PredictionResult>> mautoCompleteSearch(String place) async {
    List<PredictionResult> suggestions = [];
    place = place.replaceAll(" ", "+");
    var endpoint =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?" +
            "key=$googleApiKey&" +
            "input={$place}&sessiontoken=${this.sessionToken}";
    try {
      var response = await http.get(endpoint);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> predictions = data['predictions'];

        for (dynamic i in predictions) {
          print(predictions);
          PredictionResult res = new PredictionResult();
          res.id = i['place_id'];
          res.name = i['description'];
          suggestions.add(res);
        }
      } else {
        PredictionResult res = new PredictionResult();
        res.name = " No places found !";
        suggestions.add(res);
      }
    } catch (e) {
      PredictionResult res = new PredictionResult();
      res.name = e.toString();
      suggestions.add(res);
    }
    return suggestions;
  }

  Future<LatLng> decodeAndSelectPlace(String placeId) async {
    LatLng result;
    String endpoint =
        "https://maps.googleapis.com/maps/api/place/details/json?key=$googleApiKey" +
            "&placeid=$placeId";

    var response = await http.get(endpoint);

    if (response.statusCode == 200) {
      Map<String, dynamic> location =
      jsonDecode(response.body)['result']['geometry']['location'];

      result = LatLng(location['lat'], location['lng']);
      print("${result.longitude},,,, ${result.latitude}");

      return result;
    }
  }
}
