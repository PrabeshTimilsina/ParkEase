import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:park_ease/data/constants.dart';
import 'package:park_ease/presentation/components/my_button.dart';
import 'package:park_ease/presentation/pages/home.dart';
import 'package:http/http.dart' as http;
import '../components/my_textfield.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final addressController = TextEditingController();

  final nameController = TextEditingController();

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text
      };
      print(regBody);
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['success']);
      if (jsonResponse['success']) {
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
                  width: mediaquery.height * 0.18,
                  height: mediaquery.height * 0.18,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: addressController,
                  hintText: 'address',
                  obscureText: false,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                MyButton(
                  buttonName: 'Sign up',
                  onTap: () {
                    registerUser();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             const MyHomePage(title: "Home")));
                  },
                ),
                SizedBox(height: mediaquery.height * 0.025),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyHomePage(title: "Home")));
                  },
                  child: const Text(
                    'Continue as Guest',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
