import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:petrol_pump/SearchItem.dart';

const googleApiKey = "AIzaSyDmFsYarIa5yJppIMjJ0zph2e3X8bWI0tA";
const baseUrl = "http://maps.googleapis.com";

class CustomSearch extends SearchDelegate {
  final places = new GoogleMapsPlaces(apiKey: googleApiKey);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<SearchResult> result = List();
    return FutureBuilder(
        future: autoCompleteSearch(query),
        builder: (BuildContext context,
            AsyncSnapshot<PlacesAutocompleteResponse> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            for (var i in data.predictions) {
              var _searchResult = SearchResult(i.description,"","");
              result.add(_searchResult);
            }
            return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  var item = result[index];
                  return SearchItem(item: item,);
                });
          } else {
            return Container();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<PlacesAutocompleteResponse> autoCompleteSearch(String text) async {
    PlacesAutocompleteResponse response = await places.autocomplete(text);
    return response;
  }
}
