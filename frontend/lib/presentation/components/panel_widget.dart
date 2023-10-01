import 'package:flutter/material.dart';
import 'package:park_ease/classes/nearby_parkings.dart';
import 'package:park_ease/presentation/pages/parking_lists.dart';
import 'package:park_ease/providers/current_address_model.dart';
import 'package:park_ease/presentation/components/custom_appbar.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/components/square_tile.dart';
import 'package:park_ease/providers/current_location_model.dart';
import 'package:provider/provider.dart';

var Vehicle;

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  const PanelWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) => ListView(
        controller: controller,
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 12,
          ),
          buildDragHandle(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Vehicle = 'Motorcycle';
                },
                child:
                    const SquareTile(imageLocation: 'assets/images/bike.jpg'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              InkWell(
                onTap: () {
                  Vehicle = 'Car';
                },
                child: const SquareTile(imageLocation: 'assets/images/car.jpg'),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<CurrentAddressModel>(
              builder: (context, currentAddressModel, child) {
            TextEditingController textEditingController =
                TextEditingController(text: currentAddressModel.currentAddress);
            if (currentAddressModel.currentAddress == null) {
              textEditingController.text = "Current Location";
            }
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  TextField(
                      onTap: () {
                        showSearch(
                            context: context, delegate: MySearchDelegate());
                      },
                      controller: textEditingController,
                      obscureText: false),
                  const Divider(height: 1)
                ],
              ),
            );
          }),
          const SizedBox(
            height: 15,
          ),
          Consumer<CurrentLocationModel>( builder: (context, currentLocationModel, child) {
            return MyButton(
              onTap: () async {
                
                NearbyParkings nearbyParkings = NearbyParkings(currentLocation: currentLocationModel.currentLocation);
                await nearbyParkings.setParkingAreas(location: currentLocationModel.currentLocation);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => parkingList(nearbyParkings: nearbyParkings,)),
                );
              },
              buttonName: 'Nearest Parking',
            );}
          )
        ],
      );
}

Widget buildDragHandle() => Center(
      child: Container(
        width: 30,
        height: 5,
        decoration: BoxDecoration(color: Colors.grey[300]),
      ),
    );
