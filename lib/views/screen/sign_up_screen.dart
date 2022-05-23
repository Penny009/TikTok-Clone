// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../widgets/text_input_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(
                      'asset/images/burger.jpg',
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () {
                        authControlers.pickImage();
                      },
                      child: const Icon(
                        Icons.camera_alt_sharp,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _userNameController,
                  labelText: 'Username',
                  isObscure: false,
                  hintText: 'Enter your username',
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  isObscure: false,
                  labelText: 'email',
                  hintText: 'Enter your email',
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordController,
                  isObscure: true,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  icon: Icons.password,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    authControlers.signUpUser(
                        _userNameController.text,
                        _emailController.text,
                        _passwordController.text,
                        authControlers.ProfilePhoto!);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 400,
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      // textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.starColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
