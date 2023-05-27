import 'package:cinema_app/firebase_services/firebase_auth.dart';
import 'package:cinema_app/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_texfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void signUpUser() {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.purple.shade50),
                  child: Image.asset(
                    'assets/images/image3.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Add your Phone Number, we will send you a verification code',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter your Name',
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter your password',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Confirm your password',
                  controller: confirmPasswordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: signUpUser,
                    text: 'Register',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'If you already have an account, ',
                      style: TextStyle(color: Colors.black38),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'login',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
