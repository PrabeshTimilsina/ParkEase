import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'dart:developer' as developer;

// WEST SOUTH EAST NORTH
const boundingBoxForNepal =
    (80.0884245137, 26.3978980576, 88.1748043151, 30.4227169866);

// default constructor
MapController mapController = MapController.customLayer(
    initPosition: GeoPoint(latitude: 27.61998, longitude: 85.53904),
    areaLimit: BoundingBox(
      east: boundingBoxForNepal.$3,
      north: boundingBoxForNepal.$4,
      south: boundingBoxForNepal.$2,
      west: boundingBoxForNepal.$1,
    ),
    customTile: CustomTile.publicTransportationOSM());

class Maps extends StatefulWidget {
  const Maps({super.key, this.initialLocation});

  final GeoPoint? initialLocation;

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  GeoPoint? _initialLocation;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topRight, children: [
      // the map layer
      OSMFlutter(
        onMapIsReady: (p0) async {
          // placing these inside of onInit caused runtime error

          // limiting map area (Doesn't work).
          mapController.limitAreaMap(BoundingBox(
            east: boundingBoxForNepal.$3,
            north: boundingBoxForNepal.$4,
            south: boundingBoxForNepal.$2,
            west: boundingBoxForNepal.$1,
          ));

          _initialLocation = (widget.initialLocation == null) ? await mapController.myLocation() : widget.initialLocation;

          mapController.goToLocation(_initialLocation!);
         
        },
        controller: mapController,
        osmOption: OSMOption(
          showDefaultInfoWindow: false,
          showZoomController: true,
          enableRotationByGesture: true,
          userTrackingOption: const UserTrackingOption(
            enableTracking: true,
            unFollowUser: true,
          ),
          zoomOption: const ZoomOption(
            initZoom: 8,
            minZoomLevel: 3,
            maxZoomLevel: 18,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(
                Icons.double_arrow,
                size: 48,
              ),
            ),
          ),
          roadConfiguration: const RoadOption(
            roadColor: Colors.yellowAccent,
          ),
          markerOption: MarkerOption(
              defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          )),
        ),
        onGeoPointClicked: (point) async {
          await mapController.goToLocation(point);
          
          await mapController.setZoom(
              zoomLevel: 18); // zooming to max zoom level
        },
      ),
      // The layer above the map
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // placing search box and suggestions together
        Column(children: [
          Container()
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.local_parking),
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.location_searching_sharp),
            iconSize: 30,
            onPressed: () async {
              mapController.currentLocation();
              mapController.setZoom(zoomLevel: 18);
            },
          )
        ])
      ])
    ]);
  }
}

void addParkingMarker(GeoPoint parkingLocation) async {
  await mapController.addMarker(parkingLocation,
      markerIcon: const MarkerIcon(icon: Icon(Icons.not_listed_location_sharp)),
      iconAnchor: IconAnchor(
        anchor: Anchor.top,
      ));
}

void removeParkingMarker(GeoPoint parkingLocation) async {
  await mapController.removeMarker(parkingLocation);
}
