import 'package:authentication_with_firebase/user_auth/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_toast/toast.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'auth_sucess_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isSigningUp = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Center(
                    child: Text(
                  'Welcome to this Application.',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
                )),
                const SizedBox(height: 26),
                const Text(
                  'Enter your user Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your user name";
                      }
                    },
                    controller: _usernameController,
                    title: 'User Name',
                    isPasswordField: false,
                    prifixicon: const Icon(Icons.man)),
                const SizedBox(height: 16),
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
                    controller: _emailController,
                    title: 'User Email',
                    isPasswordField: false,
                    prifixicon: const Icon(Icons.email)),
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
                    controller: _passwordController,
                    title: 'User Password',
                    isPasswordField: true,
                    prifixicon: const Icon(Icons.password_outlined),
                    sufixicons: const Icon(Icons.remove_red_eye)),
                const SizedBox(height: 26),
                Center(
                    child: isSigningUp
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : CustomButton(title: 'SignUp', onpress: _signUp)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "User is successfully created");
      Get.to(const AuthSucessScreen());
    } else {
      showToast(message: "Some error happened");
    }
  }
}
