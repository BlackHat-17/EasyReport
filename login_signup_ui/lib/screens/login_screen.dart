import 'package:flutter/material.dart';
import '../widgets/background.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/responsive.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: SingleChildScrollView(
            child: Responsive(
              mobile: loginForm(context),
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: FlutterLogo(size: 200)),
                  Expanded(child: loginForm(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const CustomInputField(hintText: 'Email'),
          const CustomInputField(hintText: 'Password', obscureText: true),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: const Text('Don\'t have an account? Sign up'),
          ),
        ],
      ),
    );
  }
}
