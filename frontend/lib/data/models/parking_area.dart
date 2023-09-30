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

// Creating sample objects to use in listview.builder in parkinglist.dart

List<ParkingAreaModel> parking = [
  const ParkingAreaModel(
    id: '1',
    name: 'Parking Area 1',
    latitude: 123.456,
    longitude: 789.012,
    maxCapacity: 100,
    ratings: 4.5,
    ratePerHour: 10.0,
    parkingAreaType: ParkingAreaType.public,
    allowedVehicles: [ParkableVehicles.bike, ParkableVehicles.car],
  ),
  const ParkingAreaModel(
    id: '2',
    name: 'Parking Area 2',
    latitude: 456.789,
    longitude: 987.654,
    maxCapacity: 50,
    ratings: 3.5,
    ratePerHour: 8.0,
    parkingAreaType: ParkingAreaType.private,
    allowedVehicles: [ParkableVehicles.car],
  ),
  const ParkingAreaModel(
    id: '3',
    name: 'Parking Area 3',
    latitude: 476.789,
    longitude: 977.654,
    maxCapacity: 50,
    ratings: 3.0,
    ratePerHour: 15.0,
    parkingAreaType: ParkingAreaType.private,
    allowedVehicles: [ParkableVehicles.car],
  ),
  const ParkingAreaModel(
    id: '4',
    name: 'Parking Area 4',
    latitude: 466.789,
    longitude: 987.654,
    maxCapacity: 50,
    ratings: 4.0,
    ratePerHour: 20.0,
    parkingAreaType: ParkingAreaType.private,
    allowedVehicles: [ParkableVehicles.car, ParkableVehicles.bike],
  ),
];
