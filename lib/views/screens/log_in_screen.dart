import 'package:authentication_with_firebase/views/screens/sign_up_screen.dart';
import 'package:authentication_with_firebase/views/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../global_toast/toast.dart';
import '../../user_auth/firebase_auth_services.dart';
import '../widgets/custom_button.dart';
import 'auth_sucess_screen.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSigning = false;
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                    },
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
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                    },
                    title: 'User Password',
                    isPasswordField: true,
                    prifixicon: const Icon(Icons.password),
                    sufixicons: const Icon(Icons.remove_red_eye)),
                const SizedBox(height: 26),
                Center(
                  child: _isSigning
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : CustomButton(
                          title: 'LogIn',
                          onpress: () {
                            if (_formKey.currentState!.validate()) {
                              Get.to(const AuthSucessScreen());
                            }
                          },
                        ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  title: 'Sign in with Google',
                  onpress: () {
                    _signInWithGoogle();
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
                        Get.to(const SignUpScreen());
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

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Get.to(const AuthSucessScreen());
    } else {
      showToast(message: "some error occurred");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        Get.to(const AuthSucessScreen());
      }
    } catch (e) {
      showToast(message: "some error occurred $e");
    }
  }
}
