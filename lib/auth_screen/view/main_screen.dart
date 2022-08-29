import 'package:flutter/material.dart';
import 'package:one_firebase/login/google_signin.dart';
import 'package:one_firebase/login/google_signup.dart';
import 'package:one_firebase/login/signin_screen.dart';
import 'package:one_firebase/login/signup_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const SignUpEmailPassword())));
                },
                child: const Text('Email/Password Sign Up'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const EmailPasswordLogin())));
                },
                child: const Text('Email/Password Login in'),
              ),
              ElevatedButton(
                  child: const Text('Google Sign in'),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GoogleSignIn()))),
              ElevatedButton(
                  child: const Text('Google Sign Up'),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => GoogleSignUp())))
            ],
          ),
        ),
      ),
    );
  }
}
