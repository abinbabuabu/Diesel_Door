import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class SearchView extends PlacesAutocompleteWidget {
  SearchView(String apiKey) : super(apiKey: apiKey);

  @override
  State<PlacesAutocompleteWidget> createState() => _SearchViewState();
}

class _SearchViewState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarPlacesAutoCompleteTextField(),
      ),
      body: PlacesAutocompleteResult(
        onTap: (p) {
          print("Prediction Result");
        },
      ),
    );
  }
}
