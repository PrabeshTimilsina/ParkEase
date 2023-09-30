import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:park_ease/data/constants.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/pages/home.dart';
import 'package:http/http.dart' as http;
import '../components/my_textfield.dart';

class Admin extends StatefulWidget {
  Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final locationController = TextEditingController();

  final typeController = TextEditingController();

  final nameController = TextEditingController();
  final vehicleController = TextEditingController();
  final capacityController = TextEditingController();
  double rating = Random().nextDouble();

  void registerPark() async {
    if (nameController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        vehicleController.text.isNotEmpty &&
        typeController.text.isNotEmpty &&
        capacityController.text.isNotEmpty) {
      var regBody = {
        "name": nameController,
        "location": {
          {
            "address": locationController,
            "latitude": "something",
            "longitude": "something"
          }
        },
        "categories": [
          {
            "vehicleType": vehicleController,
            "rate": rating,
            "capacity": capacityController
          }
        ],
        "parkingType": typeController,
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Home")));
      }
    } else {
      print("Error while sending Registration information");
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
                  "Register your Park",
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
                  controller: vehicleController,
                  hintText: 'vehicle type',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: typeController,
                  hintText: 'parking type',
                  obscureText: true,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: capacityController,
                  hintText: 'Capacity',
                  obscureText: true,
                ),
                SizedBox(height: mediaquery.height * 0.1),
                MyButton(
                  buttonName: 'Submit',
                  onTap: () {
                    // registerPark();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyHomePage(title: "Home")));
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
