import 'package:flutter/material.dart';
import 'package:one_firebase/home_screen/home_screen.dart';

class ButtonNextPage extends StatelessWidget {
  const ButtonNextPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
        //  onAddStudentButtonClicked(context);
      },
      child: const Text('Next Page'),
    );
  }
}
