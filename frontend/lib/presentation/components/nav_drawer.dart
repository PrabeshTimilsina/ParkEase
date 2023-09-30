import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:park_ease/data/constants.dart';

import 'dart:developer' as developer;

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // since there are few items, Column is enough and ListView isn't required
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // identifier for the logged in ID
          children: [
            GestureDetector(
                onTap: () {
                  // show user account
                },
                child: const SizedBox(
                  height: 100,
                  width: double.maxFinite,
                  child: DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('username@userdomain.com')],
                    ),
                  ),
                )),
            Expanded(
              // make the main items fill the whole available space
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.label_important),
                    title: const Text('Core Functionality'),
                    onTap: () {
                      Navigator.pushNamed(context, '/core_functionality');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Admin'),
                    onTap: () {
                      Navigator.pushNamed(context, '/admin');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      var response = await http.get(
                        Uri.parse(logout),
                        headers: {"Content-Type": "application/json"},
                      );
                      var jsonResponse = jsonDecode(response.body);
                      developer.log(jsonResponse['success']);
                      if (jsonResponse['success']) {
                        Navigator.pushNamed(context, '/signup');
                      } else {
                        Navigator.pushNamed(context, '/signup');
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Quit'),
                    onTap: () {
                      Navigator.pushNamed(context, '/quit');
                    },
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, "/settings");
              },
            ),
          ]),
    );
  }
}
