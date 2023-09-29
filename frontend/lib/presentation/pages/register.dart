import 'package:flutter/material.dart';
import 'package:park_ease/presentation/components/my_button.dart';

import '../components/my_textfield.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
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
                Icon(
                  Icons.lock,
                  size: mediaquery.height * 0.17,
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
                  controller: passwordController,
                  hintText: 'Confirm password',
                  obscureText: true,
                ),
                SizedBox(height: mediaquery.height * 0.025),
                SizedBox(
                  height: mediaquery.height * 0.025,
                ),
                const MyButton(
                  buttonName: 'Sign up',
                ),
                SizedBox(height: mediaquery.height * 0.05),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Placeholder()));
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
