import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: CustomAppBar(customTitle: widget.title),
      body: const Center(child: Maps(initialLocation: null))
    );
  }
}
