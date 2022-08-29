import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> adduserDetails(
  String name,
  int age,
  int phonenumber,
  String place,
  String image,
) async {
  await FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email.toString())
      .add({
    'name': name,
    'age': age,
    'phone number': phonenumber,
    'place': place,
    'image': image,
  });
}
