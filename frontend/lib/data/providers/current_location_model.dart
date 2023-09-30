import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class CurrentLocationModel extends ChangeNotifier {

  GeoPoint? currentLocation;

  void setCurrentLocation(GeoPoint? geoPoint) {
    currentLocation = geoPoint;
    notifyListeners();
  }

  GeoPoint? getCurrentLocation() {
    return currentLocation;
  }

}