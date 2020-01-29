import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geolocation.dart';

import 'package:gochi_gochi_client/helpers/google_maps_api.dart';
import 'package:gochi_gochi_client/views/maps/search_page.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const jejuSiCoordinates = LatLng(33.509, 126.522);

  static const jejuSiZoom = 11.0;

  static const currentLocationZoom = 15.0;

  var _completer = Completer<GoogleMapController>();

  var _markers = Map<MarkerId, Marker>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Navigation'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(_createRoute(SearchPage()));
              })
        ]),
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: jejuSiCoordinates, zoom: jejuSiZoom),
            markers: Set<Marker>.of(this._markers.values)),
        floatingActionButton: FloatingActionButton(
            onPressed: _goToCurrentLocation,
            child: Transform(
                transform: Matrix4.rotationZ(-pi / 6),
                alignment: FractionalOffset.center,
                child: Icon(Icons.navigation))));
  }

  void _onMapCreated(GoogleMapController controller) {
    _completer.complete(controller);
  }

  void _goToCurrentLocation() async {
    var geolocation = GoogleMapsGeolocation(apiKey: GoogleMapsApi.key);
    var response = await geolocation.getGeolocation();
    if (response.isOkay) {
      var coordinates = LatLng(response.location.lat, response.location.lng);
      var position =
          CameraPosition(target: coordinates, zoom: currentLocationZoom);
      var controller = await _completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(position));
      setState(() {
        var id = MarkerId('currentLocation');
        this._markers[id] = Marker(markerId: id, position: coordinates);
      });
    } else {
      print(response.errorMessage);
    }
  }

  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}
