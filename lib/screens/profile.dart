import 'package:cinema_app/screens/log_in_screen.dart';
import 'package:cinema_app/widgets/custom_texfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      // Handle sign out error
      print('Sign Out Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.purple,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(controller: nameController, hintText: 'Your Name'),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: emailController, hintText: 'Your Email'),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: phoneController, hintText: 'Your Phone Number'),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: ElevatedButton(
                onPressed: () => signOut(context),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Colors.black,
                    minimumSize: const Size(40, 40),
                    backgroundColor: Colors.white,
                    elevation: 15),
                child: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 25,
                ),
              ),
              title: const Text(
                'Log out',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
