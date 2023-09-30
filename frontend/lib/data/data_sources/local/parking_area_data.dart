import 'dart:isolate';

import 'package:flutter/services.dart' show rootBundle;
import 'package:park_ease/data/models/parking_area.dart';
import 'package:park_ease/domain/entities/parking_area_entity.dart';

const String parkingAreasFilename = 'assets/parking_areas/parking_areas.csv';

Future<List<ParkingAreaModel>> parkingAreas() async {

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
    int maxCapacity = int.parse(props[4]);
    double ratings = double.parse(props[5]);

    ParkingAreaType? parkingAreaType;

    if (props.length > 6) {
      double ratePerHour = double.parse(props[6]);
      switch (props[7].toString().toLowerCase()) {
        case "private":
          parkingAreaType = ParkingAreaType.private;
          break;
        case "public":
          parkingAreaType = ParkingAreaType.public;
          break;
        default:
          parkingAreaType = ParkingAreaType.public;
      }
      List<ParkableVehicles> allowedVehicles = [];
      if (props[8].toLowerCase().contains('c')) {
        // car
        allowedVehicles.add(ParkableVehicles.car);
      }
      if (props[8].toLowerCase().contains('b')) {
        // bike
        allowedVehicles.add(ParkableVehicles.bike);
      }

      if (allowedVehicles.isEmpty) {
        // if none are allowed (if there is none stored)
        allowedVehicles.add(ParkableVehicles.none);
      }

      parkingAreas.add(ParkingAreaModel(
          id: id,
          name: name,
          latitude: latitude,
          longitude: longitude,
          maxCapacity: maxCapacity,
          ratings: ratings,
          ratePerHour: ratePerHour,
          parkingAreaType: parkingAreaType,
          allowedVehicles: allowedVehicles));
    } else {
      parkingAreas.add(ParkingAreaModel(
          id: id,
          name: name,
          latitude: latitude,
          longitude: longitude,
          maxCapacity: maxCapacity,
          ratings: ratings));
    }
  }
  sndPort.send(parkingAreas);
  return parkingAreas;
}
