import 'package:flutter/material.dart';

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
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pushNamed(context, '/logout');
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
