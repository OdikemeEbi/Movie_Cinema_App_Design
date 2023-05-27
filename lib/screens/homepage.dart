import 'package:cinema_app/screens/log_in_screen.dart';
import 'package:cinema_app/screens/sign_up_screen.dart';
import 'package:cinema_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/image1.jpg',
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Lets get Started',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Never a Better time than Now to Start',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    text: 'Get started',
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
