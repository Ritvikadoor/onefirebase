import 'package:flutter/material.dart';
import 'package:one_firebase/auth_screen/controller/auth_provider.dart';
import 'package:one_firebase/add_screen/view/profile.dart';
import 'package:one_firebase/auth_screen/widgets/custom_button.dart';
import 'package:one_firebase/login/presentation/google_signin.dart';
import 'package:one_firebase/login/presentation/google_signup.dart';
import 'package:one_firebase/login/presentation/signup_screen.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:provider/provider.dart';

class EmailPasswordLogin extends StatelessWidget {
  EmailPasswordLogin({Key? key}) : super(key: key);

  final TextEditingController emailSignInController = TextEditingController();
  final TextEditingController passwordSignInController =
      TextEditingController();
  // @override
  // void dispose() {
  //   emailSignInController.dispose();
  //   passwordSignInController.dispose();
  //   super.dispose();
  // }

  void singIn(AuthProvider provider, BuildContext context) async {
    final msg = await provider
        .signIn(emailSignInController.text, passwordSignInController.text)
        .then((value) => RoutesProvider.removeScreen(screen: ScreenAdd()));

    if (msg == '') return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'Sign-in',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: emailSignInController,
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
                      controller: passwordSignInController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        hintText: 'Enter your Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (authProvider.isLoading) const CircularProgressIndicator(),
                  if (!authProvider.isLoading)
                    ElevatedButton(
                      onPressed: () => singIn(authProvider, context),
                      child: const Text('Sign in'),
                    ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 90,
                      ),
                      const Text('Do you have an Account?'),
                      TextButton(
                        onPressed: () {
                          RoutesProvider.nextScreen(
                              screen: const SignUpEmailPassword());
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: InkWell(
            child: customButton(
                context, 'Google Sign In', Icons.now_widgets_outlined),
            onTap: () {
              RoutesProvider.nextScreen(screen: const GoogleSignIn());
            },
          ),
        ),
        InkWell(
          child: customButton(context, 'Sign Up', Icons.account_box),
          onTap: () {},
        ),
      ]),
    );
  }
}
