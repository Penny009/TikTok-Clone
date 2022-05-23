import 'package:flutter/material.dart';
import 'package:med_app/constants/colors.dart';
import 'package:med_app/views/screen/sign_up_screen.dart';
import 'package:med_app/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: const Icon(Icons.arrow_back),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: 'email',
                isObscure: false,
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
                labelText: 'Password',
                isObscure: true,
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
                  authControlers.loginUser(_emailController.text.trim(),
                      _passwordController.text.trim());
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 400,
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                  ),
                  decoration: const BoxDecoration(color: AppColors.starColor),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return SignUpScreen();
                    }));
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: AppColors.starColor, fontSize: 18),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
