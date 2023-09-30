import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/components/my_textfield.dart';
import 'package:park_ease/presentation/components/square_tile.dart';
import 'package:park_ease/presentation/pages/home.dart';
import 'package:park_ease/presentation/pages/register.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {"email": emailController, "password": passwordController};
      var response = await http.post(Uri.parse('endpoint for login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(title: "Home")));
      }
    } else {
      print("Error while sending Registration information");
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: mediaquery.height * 0.05),
                Image.asset(
                  'assets/images/Logo.png',
                  width: 130,
                  height: 130,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                const Text(
                  'Welcome back!',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: mediaquery.height * 0.05),
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end, children: []),
                ),
                SizedBox(
                  height: mediaquery.height * 0.025,
                ),
                const MyButton(
                  buttonName: 'Login',
                ),
                SizedBox(height: mediaquery.height * 0.025),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ))
                    ],
                  ),
                ),
                SizedBox(height: mediaquery.height * 0.025),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imageLocation: 'assets/images/google.png'),
                    SizedBox(
                      width: 100,
                    ),
                    SquareTile(imageLocation: 'assets/images/apple.png')
                  ],
                ),
                SizedBox(height: mediaquery.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
