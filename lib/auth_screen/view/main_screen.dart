import 'package:flutter/material.dart';
import 'package:one_firebase/auth_screen/widgets/custom_button.dart';
import 'package:one_firebase/login/presentation/google_signin.dart';
import 'package:one_firebase/login/presentation/google_signup.dart';
import 'package:one_firebase/login/presentation/signin_screen.dart';
import 'package:one_firebase/login/presentation/signup_screen.dart';
import 'package:one_firebase/routes/routs.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("How you would like to join with Us"),
              InkWell(
                child: customButton(context, 'Sign Up', Icons.account_box),
                onTap: () {
                  RoutesProvider.nextScreen(
                      screen: const SignUpEmailPassword());
                },
              ),
              InkWell(
                child: customButton(
                    context, 'Sign In', Icons.account_circle_outlined),
                onTap: () {
                  RoutesProvider.nextScreen(screen: EmailPasswordLogin());
                },
              ),
              InkWell(
                child: customButton(
                    context, 'Google Sign In', Icons.now_widgets_outlined),
                onTap: () {
                  RoutesProvider.nextScreen(screen: const GoogleSignIn());
                },
              ),
              InkWell(
                child: customButton(
                    context, 'Google Sign Up', Icons.widgets_sharp),
                onTap: () {
                  RoutesProvider.nextScreen(screen: const GoogleSignUp());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
