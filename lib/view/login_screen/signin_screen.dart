import 'package:flutter/material.dart';
import 'package:one_firebase/constant.dart';
import 'package:one_firebase/controller/auth_controller/controller/auth_provider.dart';
import 'package:one_firebase/view/home_screen/home_screen.dart';
import 'package:one_firebase/view/google_signin/google_signin.dart';
import 'package:one_firebase/view/signup_screen/signup_screen.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:provider/provider.dart';

class EmailPasswordLogin extends StatelessWidget {
  EmailPasswordLogin({Key? key}) : super(key: key);
  final formkey = GlobalKey<FormState>();

  final TextEditingController emailSignInController = TextEditingController();
  final TextEditingController passwordSignInController =
      TextEditingController();

  void singIn(AuthProvider provider, BuildContext context) async {
    final msg = await provider
        .signIn(emailSignInController.text, passwordSignInController.text)
        .then(
            (value) => RoutesProvider.removeScreen(screen: const HomeScreen()));

    if (msg == '') return;
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
          child: Form(
            key: formkey,
            child: Container(
              height: 330,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          controller: emailSignInController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            hintText: 'Enter your email',
                          ),
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
                        controller: passwordSignInController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'Enter your Password',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (authProvider.isLoading)
                      const CircularProgressIndicator(),
                    if (!authProvider.isLoading)
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            singIn(authProvider, context);
                          }
                        },
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
                                screen: SignUpEmailPassword());
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
        ),
        height40,
        InkWell(
          onTap: () {
            RoutesProvider.nextScreen(screen: const GoogleSignIn());
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      //   borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        "lib/assets/googlelogo.webp",
                        width: 50,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('Sign in with Google'),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
