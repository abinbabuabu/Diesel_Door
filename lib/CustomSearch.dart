import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

const googleApiKey = "AIzaSyACxC2oh38YG2SxmdMpRPPhpFaWAbP6TyY";
const baseUrl ="http://maps.googleapis.com";

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var result = ListView(children: <Widget>[Text("No Value")],);
     autoCompleteSearch(query).then((value){
       result = value;
     });
     return result;
  }

  Future<ListView> autoCompleteSearch(String text) async {
    print(text);
    List<String> list = List();
    PlacesAutocompleteResponse response = await places.autocomplete(text);
    if (response.isOkay) {
      print("respone is Okay");
      for (var p in response.predictions) {
        list.add(p.description);
      }

    }
    print(response.errorMessage);
    return ListView.builder(itemBuilder: (BuildContext context, int index) {
      return new Text(list[index]);
    });
  }
}
