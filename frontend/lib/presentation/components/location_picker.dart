import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:park_ease/providers/current_location_model.dart';
import 'package:park_ease/presentation/pages/home.dart';
import 'package:provider/provider.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key, this.initialLocation, this.initialAddress});

  final String? initialAddress;
  final GeoPoint? initialLocation;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late PickerMapController pickerController = PickerMapController(
      initMapWithUserPosition:
          const UserTrackingOption(enableTracking: true, unFollowUser: true));

  @override
  Widget build(BuildContext context) {
    return CustomPickerLocation(
        controller: pickerController,
        onMapReady: (ready) {
          if (ready) {
            pickerController.osmBaseController.setZoom(zoomLevel: 18);
            if (widget.initialLocation != null) {
              // setting to current location
              pickerController.osmBaseController
                  .goToPosition(widget.initialLocation!);
            }
          }
        },
        bottomWidgetPicker: Positioned(
            bottom: 12,
            right: 8,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.location_searching_sharp),
                    onPressed: () {
                      pickerController.osmBaseController.currentLocation();
                    },
                  ),
                  Consumer<CurrentLocationModel>(
                    builder: (context, currentLocation, child) {
                      return IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_circle_right_outlined),
                        onPressed: () async {
                          GeoPoint p = await pickerController
                              .selectAdvancedPositionPicker();
                          context
                              .read<CurrentLocationModel>()
                              .setCurrentLocation(p);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: "Home",
                                  )));
                        },
                      );
                    },
                  )
                ])));
  }
}
