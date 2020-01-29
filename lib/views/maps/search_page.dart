import 'package:flutter/material.dart';

import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:gochi_gochi_client/helpers/google_maps_api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._searchTextController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Search')),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
              controller: this._searchTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search for a location',
              )),
        ));
  }

  void _onSearchTextChanged() async {
    var geolocation = GoogleMapsGeolocation(apiKey: GoogleMapsApi.key);
    var response = await geolocation.getGeolocation();
    if (response.isOkay) {
      var query = this._searchTextController.text;
      var location = Location(response.location.lat, response.location.lng);
      var places = GoogleMapsPlaces(apiKey: GoogleMapsApi.key)
          .searchByText(query, location: location, radius: 50.0);
      places.whenComplete(() {
        // TODO: Create a list of results below the search text field.
        print("Got results!");
      });
    } else {
      print(response.errorMessage);
    }
  }

  @override
  void dispose() {
    this._searchTextController.dispose();
    super.dispose();
  }
}
