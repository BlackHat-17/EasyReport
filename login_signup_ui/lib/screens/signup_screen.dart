import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/responsive.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                  Expanded(child: FlutterLogo(size: 200)),
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
          const CustomInputField(hintText: 'Username'),
          const CustomInputField(hintText: 'Email'),
          const CustomInputField(hintText: 'Password', obscureText: true),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
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
