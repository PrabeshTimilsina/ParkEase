import 'package:flutter/material.dart';
import 'package:park_ease/presentation/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"ParkEase",
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
