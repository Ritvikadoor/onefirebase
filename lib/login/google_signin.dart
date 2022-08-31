import 'package:flutter/material.dart';
import 'package:one_firebase/controller/auth_provider.dart';
import 'package:one_firebase/view/add/profile.dart';
import 'package:provider/provider.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  void googlSigningIn(AuthProvider provider) async {
    final msg = await provider.googleSignIn().then((value) =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ScreenAdd())));
    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Google Sign-in',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          const SizedBox(height: 20),
          if (authProvider.isLoading) const CircularProgressIndicator(),
          if (!authProvider.isLoading)
            ElevatedButton(
              onPressed: () => googlSigningIn(authProvider),
              child: const Text('Google Sign in'),
            ),
        ]),
      ),
    );
  }
}
