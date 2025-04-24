import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/background.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/responsive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    }
  }

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
          CustomInputField(controller: _emailController, hintText: 'Email'),
          CustomInputField(controller: _passwordController, hintText: 'Password', obscureText: true),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: ()=> Navigator.pushNamed(context, '/profile_page'),
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
