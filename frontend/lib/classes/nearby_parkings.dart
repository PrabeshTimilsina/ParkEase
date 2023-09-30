import 'dart:developer' as developer;

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:park_ease/data/models/parking_area.dart';
import 'package:park_ease/data/repository/parking_area_repository_impl.dart';

class NearbyParkings {
  NearbyParkings({required this.currentLocation});

  GeoPoint? currentLocation;

  List<ParkingAreaModel>? nearbyParkingAreas;
  final ParkingAreaRepositoryImpl parkingAreaRepository =
      ParkingAreaRepositoryImpl();

  // initializing all for now
  Future<bool> setParkingAreas({GeoPoint? location}) async {
    location ??= currentLocation;

    final stopwatch = Stopwatch()..start();
    developer.log("Start importing parking areas: --waiting--");

    developer.log("The set location is $location");

    if (location == null)  return false;

    List<ParkingAreaModel> pA = await parkingAreaRepository.getParkingAreas(
        location.latitude, location.longitude);
    developer
        .log("Finished importing parking areas. Took ${stopwatch.elapsed}");

    nearbyParkingAreas = pA;
    
    if (pA.isEmpty) return false;

    return true;
  }

  Future<ParkingAreaModel?> getParkingArea(GeoPoint location) {
    return parkingAreaRepository.getParkingArea(
        location.latitude, location.longitude);
  }
}
