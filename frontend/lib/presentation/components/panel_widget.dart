import 'package:flutter/material.dart';
import 'package:park_ease/data/providers/current_address_model.dart';
import 'package:park_ease/data/providers/current_location_model.dart';
import 'package:park_ease/presentation/components/custom_appbar.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/components/my_textfield.dart';
import 'package:park_ease/presentation/components/square_tile.dart';
import 'package:provider/provider.dart';

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
                onTap: () {},
                child:
                    const SquareTile(imageLocation: 'assets/images/bike.jpg'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
              ),
              InkWell(
                onTap: () {},
                child: const SquareTile(imageLocation: 'assets/images/car.jpg'),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<CurrentAddressModel>(
              builder: (context, currentAddressModel, child) {
                 TextEditingController textEditingController = TextEditingController(
                    text: currentAddressModel.currentAddress);
                  if (currentAddressModel.currentAddress == null){
                    textEditingController.text = "Current Location";
                  }
            return TextField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onTap: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                controller: textEditingController,
                obscureText: false);
          }),
          const SizedBox(
            height: 15,
          ),
          MyButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Placeholder()),
              );
            },
            buttonName: 'Nearest Parking',
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
