import 'package:cinema_app/firebase_services/firebase_auth.dart';
import 'package:cinema_app/screens/preferences/shared_preferecces.dart';
import 'package:cinema_app/screens/sign_up_screen.dart';
// import 'package:cinema_app/utils/showSnackBar.dart';
import 'package:cinema_app/widgets/custom_texfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeUserPreferences();
  }

  void initializeUserPreferences() async {
    final String? savedEmail = await UserPreferences.getEmail();
    final String? savedPassword = await UserPreferences.getPassword();

    if (savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
    }
  }

  void loginUser(BuildContext context) {
    final FirebaseAuthMethods authMethods = context.read<FirebaseAuthMethods>();
    authMethods.loginWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );

    // Save user credentials
    UserPreferences.saveUserCredentials(
      emailController.text,
      passwordController.text,
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
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.shade50,
                  ),
                  child: Image.asset(
                    'assets/images/image3.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
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
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.purple),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () => loginUser(context),
                          text: 'Login',
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
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
