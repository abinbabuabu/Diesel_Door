import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:petrol_pump/SearchItem.dart';
import 'package:provider/provider.dart';

import 'GooglePlacesProvider.dart';

const googleApiKey = "AIzaSyDmFsYarIa5yJppIMjJ0zph2e3X8bWI0tA";
const baseUrl = "http://maps.googleapis.com";

class CustomSearch extends SearchDelegate {
  var provider;

  @override
  List<Widget> buildActions(BuildContext context) {
    provider = Provider.of<PlacesProvider>(context);
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
    print("Search Pressed");
    return FutureBuilder(
        future: provider.autoCompleteSearch(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<SearchResult>> snapshot) {
          if (snapshot.hasData) {
            List<SearchResult> result = snapshot.data;
            return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  var item = result[index];
                  return SearchItem(
                    item: item,
                  );
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
}
