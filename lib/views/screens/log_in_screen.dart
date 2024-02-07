import 'package:authentication_with_firebase/views/screens/sign_up_screen.dart';
import 'package:authentication_with_firebase/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_button.dart';
import 'auth_sucess_screen.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Authentication With Firebase',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                const Center(
                    child: Text(
                  'Welcome to this Application.',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
                )),
                const SizedBox(height: 26),
                const Text(
                  'Enter your Email',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                    },
                    title: 'User Email',
                    isPasswordField: false,
                    prifixicon: const Icon(Icons.password)),
                const SizedBox(height: 16),
                const Text(
                  'Enter your Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                    },
                    title: 'User Password',
                    isPasswordField: true,
                    prifixicon: const Icon(Icons.email),
                    sufixicons: const Icon(Icons.remove_red_eye)),
                const SizedBox(height: 26),
                CustomButton(
                  title: 'LogIn',
                  onpress: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(const AuthSucessScreen());
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Don\'t you have an account?'),
                    TextButton(
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 16, color: Colors.cyan),
                      ),
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
