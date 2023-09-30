import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:park_ease/presentation/components/custom_appbar.dart';

import '/presentation/components/location_picker.dart';
import '/presentation/components/nav_drawer.dart';

class LocationSelection extends StatefulWidget {
  const LocationSelection(
      {super.key, this.initialLocation, this.initialAddress});

  final String? initialAddress;
  final GeoPoint? initialLocation;

  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  @override
  Widget build(BuildContext context) {
    // not using appbar here, as it will be handled by the location_picker widget
    return Scaffold(
      appBar: CustomAppBar(customTitle: "Pick a precise location"),
      drawer: const NavDrawer(),
      body: Center(
          child: LocationPicker(
        initialLocation: widget.initialLocation,
        initialAddress: widget.initialAddress,
      )),
    );
  }
}
