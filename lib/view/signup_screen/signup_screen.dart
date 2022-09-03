import 'package:flutter/material.dart';
import 'package:one_firebase/constant.dart';
import 'package:one_firebase/controller/auth_controller/controller/auth_provider.dart';
import 'package:one_firebase/view/home_screen/home_screen.dart';
import 'package:one_firebase/view/login_screen/signin_screen.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:provider/provider.dart';

class SignUpEmailPassword extends StatelessWidget {
  SignUpEmailPassword({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailSignUpController = TextEditingController();
  final TextEditingController passwordSignUpController =
      TextEditingController();

  void singUp(AuthProvider provider, BuildContext context) async {
    final msg = await provider
        .signUp(emailSignUpController.text, passwordSignUpController.text)
        .then((value) =>
            RoutesProvider.removeScreenUntil(screen: const HomeScreen()));
    if (msg == '') return;
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'SignUp',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 350,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  height20,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter your Name',
                      ),
                    ),
                  ),
                  height20,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      controller: emailSignUpController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter your email',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      controller: passwordSignUpController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        hintText: 'Enter your Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        singUp(authProvider, context);
                      }
                    },
                    child: const Text('SignUp'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 90,
            ),
            const Text('You already have an Account?'),
            TextButton(
              onPressed: () {
                RoutesProvider.nextScreen(screen: EmailPasswordLogin());
              },
              child: const Text(
                'Sign in',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
