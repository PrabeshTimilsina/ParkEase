import 'dart:math';

import 'package:park_ease/domain/entities/parking_area_entity.dart';

class ParkingAreaModel extends ParkingAreaEntity {
  const ParkingAreaModel(
      {required super.id,
      required super.name,
      required super.latitude,
      required super.longitude,
      required super.availableSpaces,
      required super.ratings,
      super.ratePerHour,
      super.parkingAreaType = "regulated",
      required super.distance, 
      required super.duration,});

  factory ParkingAreaModel.fromJSON(Map<String, dynamic> map) {
    String? parkingAreaType = map["parkingAreaType"];
    // defaulting to public if nothing is given
    parkingAreaType ??= "unregulated";

    return ParkingAreaModel(
        id: map["_id"],
        name: map["name"],
        latitude: map["latitude"],
        longitude: map["longitude"],
        availableSpaces: map["availableSpaces"],
        ratings: Random().nextDouble(),
        ratePerHour: map["hourlyRate"],
        distance: map["distance"].toDouble(),
        duration: map["duration"],
        parkingAreaType: parkingAreaType);
  }
}
