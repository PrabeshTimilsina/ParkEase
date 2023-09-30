import 'package:flutter/material.dart';

class VehicleModel extends ChangeNotifier {

  String currentVehicle = "Car";

  void setVehicle(String v) {
    currentVehicle = v;
    notifyListeners();
  }

  String? getVehicle() {
    return currentVehicle;
  }

}