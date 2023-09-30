import 'package:flutter/material.dart';

class CurrentAddressModel extends ChangeNotifier {

  String? currentAddress;

  void setCurrentAddress(String? geoPoint) {
    currentAddress = geoPoint;
    notifyListeners();
  }

  String? getCurrentAddress() {
    return currentAddress;
  }

}