import 'package:flutter/material.dart';
import 'package:one_firebase/login/signup_screen.dart';

Widget customButton(BuildContext context, String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 45),
    child: Card(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                decoration: myBoxDecoration(),
                height: 55,
                width: 30,
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ))),
        ],
      ),
    ),
  );
}

BoxDecoration myBoxDecoration() {
  return const BoxDecoration(
    color: Colors.deepPurple,
    borderRadius:
        BorderRadius.all(Radius.circular(5.0) //         <--- border radius here
            ),
  );
}

toSignUpPage(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: ((context) => const SignUpEmailPassword())));
}
