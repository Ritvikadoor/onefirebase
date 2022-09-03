import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:one_firebase/constant.dart';
import 'package:one_firebase/model/image_profile.dart';
import 'package:one_firebase/model/user_details_firebase.dart';
import 'package:one_firebase/view/add_screen/widgets/add_profile_heading.dart';
import 'package:one_firebase/controller/auth_controller/controller/auth_provider.dart';
import 'package:one_firebase/view/home_screen/home_screen.dart';
import 'package:one_firebase/view/login_screen/signin_screen.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:provider/provider.dart';

class ScreenAdd extends StatelessWidget {
  ScreenAdd({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final placeController = TextEditingController();

  File? imagefile;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(shrinkWrap: true, children: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    const HeadingAddProfile(),
                    Center(child:
                        Consumer<AuthProvider>(builder: (context, balue, _) {
                      return ClipOval(child: imageprofile());
                    })),
                    height40,
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 219, 219, 219),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter your Name',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: ageController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter Age',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter the Number',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              controller: placeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Place',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              adduserDetails(
                                  nameController.text.trim(),
                                  int.parse(ageController.text.trim()),
                                  int.parse(phoneNumberController.text.trim()),
                                  placeController.text.trim(),
                                  context.read<AuthProvider>().imageAvtr);

                              RoutesProvider.removeScreenUntil(
                                  screen: const HomeScreen());
                              context.read<AuthProvider>().imageAvtr = '';
                            }
                          },
                          child: const Text('Add Profile'),
                        ),
                      ],
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
