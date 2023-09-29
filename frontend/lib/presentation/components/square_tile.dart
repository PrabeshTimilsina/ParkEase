import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imageLocation;
  const SquareTile({super.key, required this.imageLocation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Image.asset(
        imageLocation,
        height: 40,
      ),
    );
  }
}
