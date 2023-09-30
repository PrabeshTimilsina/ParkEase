enum ParkingAreaType { public, private }

enum ParkableVehicles { car, bike, none }

class ParkingAreaEntity {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int maxCapacity;
  final double ratings;
  final double ratePerHour;
  final ParkingAreaType parkingAreaType;
  final List<ParkableVehicles> allowedVehicles; // Only car and bike for now

  const ParkingAreaEntity(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.maxCapacity,
      required this.ratings,
      this.ratePerHour = 0, // default zero for public parkings
      this.parkingAreaType = ParkingAreaType.public, // default public parking
      this.allowedVehicles = const [
        ParkableVehicles.car,
        ParkableVehicles.bike
      ] // allowing both car and bike by default
      });
}
