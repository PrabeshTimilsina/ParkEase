import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final Function()? onTap;
  const MyButton({super.key, this.onTap, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: mediaquery.width * 0.10),
        decoration: BoxDecoration(
            color: HexColor('#30BEE5'), borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
