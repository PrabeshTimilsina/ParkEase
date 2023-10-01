import 'dart:isolate';

import 'package:flutter/services.dart' show rootBundle;
import 'package:park_ease/data/models/parking_area.dart';

const String parkingAreasFilename = 'assets/parking_areas/parking_areas.csv';

Future<List<ParkingAreaModel>> parkingAreas(double latitude, double longitude, String vecType) async {
  // separating into two different functions because
  // asset bundler didn't get initialized early on and caused plugin not initialized error
  // might be because of the use of isolates

  String csvString = await rootBundle.loadString(parkingAreasFilename);
  ReceivePort rcvPort = ReceivePort();
  SendPort sndPort = rcvPort.sendPort;
  Map<String, dynamic> map = {"sendPort": sndPort, "csvString": csvString};

  // deligate whole file parsing to another thread
  await Isolate.spawn(parkingAreasFromCSVString, map);

  await for (var message in rcvPort) {
    if (message is List<ParkingAreaModel>) {
      return message;
    }
  }

  return [];
}

Future<List<ParkingAreaModel>> parkingAreasFromCSVString(
    Map<String, dynamic> map) async {
  // getting the arguments
  String csvString = map["csvString"];
  SendPort sndPort = map["sendPort"];

  // getting each lines
  List<String> lines = csvString.split('\n');

  List<ParkingAreaModel> parkingAreas = [];

  for (String line in lines) {
    // getting individual fields
    List<String> props = line.split(',');

    // continue if there aren't enough fields
    if (props.length < 6) {
      continue;
    }
    String id = props[0].toString().toLowerCase();
    String name = props[1].toString();
    double latitude = double.parse(props[2]);
    double longitude = double.parse(props[3]);
    int availableSpaces = int.parse(props[4]);
    double ratings = double.parse(props[5]);

    int ratePerHour = int.parse(props[6]);
    double distance = double.parse(props[7]);
    double duration = double.parse(props[8]);

    parkingAreas.add(ParkingAreaModel(
        id: id,
        name: name,
        latitude: latitude,
        longitude: longitude,
        availableSpaces: availableSpaces,
        ratings: ratings,
        ratePerHour: ratePerHour,
        distance: distance,
        duration: duration));
  }
  sndPort.send(parkingAreas);
  return parkingAreas;
}
