import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  String imageAvtr = '';
  FirebaseAuth fb;
  AuthProvider(this.fb);
  bool isLoading = false;
  Stream<User?> stream() => fb.authStateChanges();
  bool get loading => isLoading;
  Future<void> signOut() async {
    await fb.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      await fb.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      await fb.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> googleSignIn() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isLoading = false;
        notifyListeners();
        return Future.value('Occurred an error while sign-in');
      }
      final credential = await result.authentication;
      final exists = await fb.fetchSignInMethodsForEmail(result.email);
      if (exists.isEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value('User dont exists');
      }
      await fb.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: credential.accessToken, idToken: credential.idToken));
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> googleSignUp() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isLoading = false;
        notifyListeners();
        return Future.value('Occurred an error while sign-in');
      }
      final credential = await result.authentication;
      final exists = await fb.fetchSignInMethodsForEmail(result.email);
      if (exists.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value('User already exists');
      }
      await fb.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: credential.accessToken, idToken: credential.idToken));
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final temp = File(image!.path).readAsBytesSync();
    imageAvtr = base64Encode(temp);
    notifyListeners();
  }

  Future<void> showBottomSheetUI(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx1) {
        return Container(
          height: 100,
          width: double.infinity,
          color: Colors.black,
          child: Column(children: [
            const Text('choise your profile photo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    takePhoto(context);
                  },
                  icon: const Icon(Icons.photo_album),
                  color: Colors.white,
                )
              ],
            )
          ]),
        );
      },
    );
  }

  Future<void> takePhoto(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final temp = File(image.path).readAsBytesSync();
    String encode = base64Encode(temp);

    context.read<AuthProvider>().imageAvtr = encode;
    notifyListeners();

// context.read<AuthProvider>().changeImage(encode);
  }

  updateData(
      {required BuildContext context,
      required String imageQ,
      required String phone,
      required String name,
      required String email,
      required String password,
      required String documentQ}) {
    FirebaseFirestore.instance.collection(email).doc(documentQ).set({
      'image': imageAvtr,
      'phone': phone,
      'name': name,
      'email': email,
      'password': password,
    });
  }
}