import 'package:park_ease/domain/entities/parking_area_entity.dart';

class ParkingAreaModel extends ParkingAreaEntity {
  const ParkingAreaModel(
      {required super.id,
      required super.name,
      required super.latitude,
      required super.longitude,
      required super.maxCapacity,
      required super.ratings,
      super.ratePerHour,
      super.parkingAreaType,
      super.allowedVehicles});

  factory ParkingAreaModel.fromJSON(Map<String, dynamic> map) {
    ParkingAreaType? parkingAreaType = map["parkingAreaType"];
    // defaulting to public if nothing is given
    parkingAreaType ??= ParkingAreaType.public;

    List<ParkableVehicles>? allowedVehicles = map["allowedVehicles"];
    // defaulting to bike and car
    allowedVehicles ??= const [ParkableVehicles.bike, ParkableVehicles.car];

    return ParkingAreaModel(
        id: map["id"],
        name: map["name"],
        latitude: map["latitude"],
        longitude: map["longitude"],
        maxCapacity: map["maxCapcacity"],
        ratings: map["ratings"],
        ratePerHour: map["ratePerHour"],
        parkingAreaType: parkingAreaType,
        allowedVehicles: allowedVehicles);
  }
}
