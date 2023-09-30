
class ParkingAreaEntity {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  /// In meters
  final double distance;
  /// To reach the parking area (in Minutes)
  final double duration;  
  final int availableSpaces;
  /// assign this randomly (for now)
  final double ratings;
  final int ratePerHour;
  final String parkingAreaType;

  const ParkingAreaEntity( 
      {required this.distance,
      required this.duration,
      required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.availableSpaces,
      required this.ratings,
      this.ratePerHour = 0, // default zero for public parkings
      this.parkingAreaType = "regulated", // default public parking // allowing both car and bike by default
      });
}
