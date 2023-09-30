import 'dart:isolate';

import 'package:park_ease/data/data_sources/remote/parking_area_data_remote.dart';
import 'package:park_ease/data/models/parking_area.dart';
import 'package:park_ease/domain/repository/parking_area_repository.dart';

class ParkingAreaRepositoryImpl implements ParkingAreaRepository {
  // storing for faster access
  List<ParkingAreaModel> areas = [];

  @override
  Future<List<ParkingAreaModel>> getParkingAreas(double latitude, double longitude, String vecType) async {
    // mock data for now
    areas = await parkingAreas(latitude, longitude, vecType);
    return areas;
  }

  @override
  Future<ParkingAreaModel?> getParkingArea(
      double latitude, double longitude) async {
    ReceivePort receivePort = ReceivePort();
    Map<String, dynamic> args = {
      "sendPort": receivePort.sendPort,
      "areas": areas,
      "latitude": latitude,
      "longitude": longitude
    };

    // delegating to new thread
    await Isolate.spawn(findOne, args);

    await for (var message in receivePort) {
      if (message is ParkingAreaModel?) {
        return message;
      }
    }

    return null;
  }
}

/// # Returns
/// Either [null] or [ParkingAreaModel] through function (if called directly) and through the SendPort
///
/// # Parameters
/// Expects the argument [map] to be a map consisting of
/// [areas],[latitude],[longitude] and [sendPort]
///
/// areas: the parking areas
///
/// latitude,longitude: the geo-location of the parking area to find
///
/// sendPort: sending end of the [ReceivePort] to return values after computation
///
Future<ParkingAreaModel?> findOne(Map<String, dynamic> map) async {
  List<ParkingAreaModel> areas = map["areas"];
  double latitude = map["latitude"];
  double longitude = map["longitude"];
  SendPort sendPort = map["sendPort"];

  for (ParkingAreaModel area in areas) {
    if (area.latitude == latitude && area.longitude == longitude) {
      sendPort.send(area);
      return area;
    }
  }
  sendPort.send(null);
  return null;
}
