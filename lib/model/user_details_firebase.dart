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
    'number': phonenumber,
    'place': place,
    'image': image,
  });
}

Future<void> updateuserDetails(
  String id,
  String name,
  String age,
  String phonenumber,
  String place,
  String image,
) async {
  final docUs = await FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.email.toString())
      .doc(id);
  docUs.set({
    'name': name,
    'age': age.toString(),
    'number': phonenumber,
    'place': place,
    'image': image,
  });
}
