import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

import 'SearchItem.dart';

const googleApiKey = "AIzaSyDmFsYarIa5yJppIMjJ0zph2e3X8bWI0tA";

class PlacesProvider with ChangeNotifier {
  GoogleMapsPlaces _places;


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
    var  response;
    _places.getDetailsByPlaceId(placeid).then((value) {
      if (value.isOkay) {
        print("value Is okey");
        response = value;
        print(value.result.formattedAddress);
      }
      else {
        print(value.errorMessage);
      }
    });
    return response;
  }
}
