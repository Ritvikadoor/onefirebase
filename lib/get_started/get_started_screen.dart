import 'package:flutter/material.dart';
import 'package:one_firebase/login/presentation/signin_screen.dart';
import 'package:one_firebase/routes/routs.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 400,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(""),
                fit: BoxFit.fill,
              ))),
          ElevatedButton(
              onPressed: () =>
                  RoutesProvider.nextScreen(screen: EmailPasswordLogin()),
              child: const Text("Continue"))
        ],
      ),
    );
  }
}
