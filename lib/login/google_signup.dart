import 'package:flutter/material.dart';
import 'package:one_firebase/controller/auth_provider.dart';
import 'package:one_firebase/view/add/profile.dart';
import 'package:provider/provider.dart';

class GoogleSignUp extends StatefulWidget {
  const GoogleSignUp({Key? key}) : super(key: key);

  @override
  State<GoogleSignUp> createState() => _GoogleSignUpState();
}

class _GoogleSignUpState extends State<GoogleSignUp> {
  void googlSigningUp(AuthProvider provider) async {
    final msg = await provider.googleSignUp().then((value) =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ScreenAdd())));
    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  // void signUp(AuthProvider provider) async {
  //   final msg = await provider.googleSignUp().then((value) =>
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => ScreenAdd())));
  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // }

  // void googleSignUp(AuthProvider provider) async {
  //   final msg = await provider
  //       .signUp(emailSignUpController.text, passwordSignUpController.text)
  //       .then((value) => Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => ScreenAdd())));
  //   if (msg == '') return;
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // }

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
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => googlSigningUp(authProvider),
          child: const Text('SignUp'),
        ),
      ]),
    );
  }
}
