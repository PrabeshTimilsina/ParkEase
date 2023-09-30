import 'package:flutter/material.dart';
import 'package:park_ease/presentation/pages/admin.dart';
import 'package:park_ease/providers/current_address_model.dart';
import 'package:park_ease/providers/current_location_model.dart';
import 'package:park_ease/presentation/pages/home.dart';
import 'package:park_ease/presentation/pages/login.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CurrentLocationModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => CurrentAddressModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ParkEase",
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => Login(),
          '/home': (BuildContext context) => const MyHomePage(
                title: "Home",
              ),
          '/signup': (BuildContext context) => Login(),
          '/admin': (BuildContext context) => Admin(),
          '/logout': (BuildContext context) => const Placeholder(),
          '/quit': (BuildContext context) => const Placeholder(),
          '/settings': (BuildContext context) => const Placeholder(),
          '/core_functionality': (BuildContext context) => const Placeholder(),
          '/location_selection': (BuildContext context) => const Placeholder(),
        });
  }
}
