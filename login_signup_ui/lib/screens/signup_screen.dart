import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: SingleChildScrollView(
            child: Responsive(
              mobile: signupForm(context),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: FlutterLogo(size: 200)),
                  Expanded(child: signupForm(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signupForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text('Sign Up', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          CustomInputField(
            hintText: 'Username',
            controller: usernameController,
          ),
          CustomInputField(
            hintText: 'Email',
            controller: emailController,
          ),
          CustomInputField(
            hintText: 'Password',
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 24),
         

ElevatedButton(
  onPressed: () async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      print("✅ Signed up: ${userCredential.user?.email}");
      
      // Navigate to dashboard or home
      Navigator.pushReplacementNamed(context, '/dashboard');
    } on FirebaseAuthException catch (e) {
      String message = '❌ Signup failed';

      if (e.code == 'weak-password') {
        message = 'Password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'This email is already registered.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  },
  child: const Text('Sign Up'),
),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Already have an account? Login'),
          ),
        ],
      ),
    );
  }
}
