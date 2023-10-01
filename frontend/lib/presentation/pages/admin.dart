import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:park_ease/data/constants.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/pages/home.dart';
import 'package:http/http.dart' as http;
import 'package:park_ease/providers/current_location_model.dart';
import 'package:provider/provider.dart';
import '../components/my_textfield.dart';

import 'dart:developer' as developer;

class Admin extends StatefulWidget {
  Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final locationController = TextEditingController();

  final typeController = TextEditingController();
  final carRateController = TextEditingController();
  final motorCycleRateController = TextEditingController();
  final nameController = TextEditingController();
  final carCapacityController = TextEditingController();
  final motorCycleCapacityController = TextEditingController();
  double rating = Random().nextDouble()*4 + 1;

  void registerPark(double latitude, double longitude) async {
    if (nameController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        typeController.text.isNotEmpty &&
        (((carCapacityController.text.isNotEmpty &&
                carRateController.text.isNotEmpty) ||
            (motorCycleCapacityController.text.isNotEmpty &&
                motorCycleRateController.text.isNotEmpty)))) {
      var regBody = {
        "name": nameController.text,
        "location": {
          "address": locationController.text,
          "latitude": latitude,
          "longitude": longitude
        },
        "categories": [
          {
            "vehicleType": "Car",
            "rate": int.parse(carRateController.text),
            "capacity": int.parse(carCapacityController.text)
          },
          {
            "vehicleType": "Motorcycle",
            "rate": int.parse(motorCycleRateController.text),
            "capacity": int.parse(motorCycleCapacityController.text)
          }
        ],
        "parkingType": typeController.text,
      };
      var response = await http.post(Uri.parse(registerlocation),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      developer.log(jsonResponse.toString());
      if (response.statusCode == 200) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Home")));
      }
    } else {
      developer.log("Error while sending Registration information");
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: mediaquery.height * 0.05),
                const Text(
                  "Register your Parking Area",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                ),
                SizedBox(height: mediaquery.height * 0.01),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      height: 5,
                      color: Colors.white,
                    )),
                SizedBox(height: mediaquery.height * 0.05),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: locationController,
                  hintText: 'location',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: typeController,
                  hintText: 'parking type (regulated, unregulated)',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: carRateController,
                  hintText: 'rate per hour for car',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: carCapacityController,
                  hintText: 'Car Capacity',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: motorCycleRateController,
                  hintText: 'rate per hour for motorcycle',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: motorCycleCapacityController,
                  hintText: 'Motorcycle Capacity',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.1),
                Consumer<CurrentLocationModel>(
                  builder: (context, currentLocationModel, child) {
                    return MyButton(
                      buttonName: 'Submit',
                      onTap: () {
                        if (currentLocationModel.currentLocation != null) {
                          registerPark(
                              currentLocationModel.currentLocation!.latitude,
                              currentLocationModel.currentLocation!.longitude);
                        } else {
                          registerPark(0, 0);
                        }

                        // registerPark();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyHomePage(title: "Home")));
                      },
                    );
                  },
                ),
                SizedBox(height: mediaquery.height * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
