import 'package:authentication_with_firebase/views/screens/log_in_screen.dart';
import 'package:authentication_with_firebase/views/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthSucessScreen extends StatelessWidget {
  const AuthSucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Authentication Successfully.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            CustomButton(
                title: 'Sign Out',
                onpress: () {
                  FirebaseAuth.instance.signOut();
                  Get.to(LogInScreen());
                })
          ],
        ),
      ),
    );
  }
}
