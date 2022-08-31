import 'package:flutter/material.dart';

class HeadingAddProfile extends StatelessWidget {
  const HeadingAddProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, top: 20),
      child: Text(
        'ADD PROFILE',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
