import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final bool isselected;
  final String imageLocation;
  const SquareTile(
      {super.key, required this.isselected, required this.imageLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: isselected ? Colors.blue : Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Image.asset(
        imageLocation,
        height: 50,
        width: 50,
      ),
    );
  }
}
