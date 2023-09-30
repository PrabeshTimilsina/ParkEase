import 'package:park_ease/data/constants.dart';
import 'package:park_ease/data/models/parking_area.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String parkingAreasFilename = 'assets/parking_areas/parking_areas.csv';

Future<List<ParkingAreaModel>> parkingAreas(
    double latitude, double longitude, String vecType) async {

  var response = await http.get(Uri.parse(
      "$getNearestParkings?latitude=$latitude&longitude=$longitude&vehicleType=$vecType"));

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);

    var parkingModelJsonArray = responseBody["distanceInfo"];

    List<ParkingAreaModel> parkingAreaModels = [];

    for (var parkingModelJson in parkingModelJsonArray) {
      parkingAreaModels.add(ParkingAreaModel.fromJSON(parkingModelJson));
    } 

    return parkingAreaModels;
  } 

  return [];
}
