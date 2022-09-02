import 'package:flutter/material.dart';
import 'package:one_firebase/auth_screen/controller/auth_provider.dart';
import 'package:one_firebase/add_screen/view/profile.dart';
import 'package:one_firebase/auth_screen/widgets/custom_button.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:provider/provider.dart';

class SignUpEmailPassword extends StatefulWidget {
  const SignUpEmailPassword({Key? key}) : super(key: key);

  @override
  State<SignUpEmailPassword> createState() => _SignUpEmailPasswordState();
}

class _SignUpEmailPasswordState extends State<SignUpEmailPassword> {
  final TextEditingController emailSignUpController = TextEditingController();
  final TextEditingController passwordSignUpController =
      TextEditingController();
  @override
  void dispose() {
    emailSignUpController.dispose();
    passwordSignUpController.dispose();
    super.dispose();
  }

  void singUp(AuthProvider provider) async {
    final msg = await provider
        .signUp(emailSignUpController.text, passwordSignUpController.text)
        .then((value) => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ScreenAdd())));
    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
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
            controller: passwordSignUpController,
            decoration: const InputDecoration(
              icon: Icon(Icons.password),
              hintText: 'Enter your Password',
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => singUp(authProvider),
          child: const Text('SignUp'),
        ),
      ]),
    );
  }
}
