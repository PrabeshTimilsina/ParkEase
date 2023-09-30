
import 'package:park_ease/domain/entities/parking_area_entity.dart';

abstract class ParkingAreaRepository {

  ///
  /// Return the parking areas
  ///
  Future<List<ParkingAreaEntity>> getParkingAreas(double latitude, double longitude, String vecType);

  ///
  /// Return the parking area corresponding to the given latitude and longitude.
  /// Returns null if no Parking Area is present with the given latitude and longitude
  /// 
  /// TODO: Implement fuzzy search based on nearest location
  ///
  Future<ParkingAreaEntity?> getParkingArea(double latitude, double longitude);
}