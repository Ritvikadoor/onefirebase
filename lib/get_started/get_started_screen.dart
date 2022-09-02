import 'package:flutter/material.dart';
import 'package:one_firebase/auth_screen/view/main_screen.dart';
import 'package:one_firebase/routes/routs.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 300,
          ),
          ElevatedButton(
              onPressed: () =>
                  RoutesProvider.nextScreen(screen: const MainScreen()),
              child: const Text("Continue"))
        ],
      ),
    );
  }
}
