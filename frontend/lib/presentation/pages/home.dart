import 'package:flutter/material.dart';
import 'package:park_ease/presentation/components/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '/presentation/components/custom_appbar.dart';
import '/presentation/components/maps.dart';
import '/presentation/components/nav_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double fabHeightClosed = 116.0;
  double fabHeight = fabHeightClosed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: CustomAppBar(customTitle: widget.title),
      body: Stack(alignment: Alignment.topCenter, children: [
        SlidingUpPanel(
          color: Theme.of(context).primaryColor,
          minHeight: MediaQuery.of(context).size.height * 0.1,
          maxHeight: MediaQuery.of(context).size.height * 0.4,
          parallaxEnabled: true,
          parallaxOffset: .5,
          body: const Center(child: Maps(initialLocation: null)),
          panelBuilder: (controller) => PanelWidget(controller: controller),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
          onPanelSlide: (position) => setState(() {
            final panelMaxScrollExtent =
                (MediaQuery.of(context).size.height * 0.4) -
                    (MediaQuery.of(context).size.height * 0.1);
            fabHeight =
                position * panelMaxScrollExtent + fabHeightClosed * 0.75;
          }),
        ),
        Positioned(right: 20, bottom: fabHeight, child: buildFAB(context)),
      ]),
    );
  }

  Widget buildFAB(BuildContext context) => FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.gps_fixed,
        color: Colors.white,
      ),
      onPressed: () {
        mapController.currentLocation();
        mapController.setZoom(zoomLevel: 18);
      });
}
