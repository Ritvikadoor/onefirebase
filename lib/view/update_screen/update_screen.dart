import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_firebase/model/user_details_firebase.dart';
import 'package:one_firebase/controller/auth_controller/controller/auth_provider.dart';
import 'package:one_firebase/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({Key? key, required this.dataQ}) : super(key: key);
  final QueryDocumentSnapshot<Object?> dataQ;
  final formkey = GlobalKey<FormState>();

  TextEditingController nameEditController = TextEditingController();
  TextEditingController ageEditController = TextEditingController();

  TextEditingController phoneNumberEditController = TextEditingController();
  TextEditingController placeEditController = TextEditingController();
  String? imgString;

  @override
  Widget build(BuildContext context) {
    nameEditController.text = dataQ['name'];
    ageEditController.text = dataQ['age'].toString();
    phoneNumberEditController.text = dataQ['number'].toString();
    placeEditController.text = dataQ['place'];
    context.read<AuthProvider>().imageAvtr = dataQ['image'];

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
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Text(
                        'EDIT PROFILE',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(child:
                        Consumer<AuthProvider>(builder: (context, balue, _) {
                      return ClipOval(child: imageUpdateprofile());
                    })),
                    const SizedBox(
                      height: 40,
                    ),
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
                                  return 'Name is required';
                                }
                                return null;
                              },
                              controller: nameEditController,
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
                                  return 'Age is required';
                                }
                                return null;
                              },
                              controller: ageEditController,
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
                                  return 'Number is required';
                                }
                                return null;
                              },
                              controller: phoneNumberEditController,
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
                                  return 'Place is required';
                                }
                                return null;
                              },
                              controller: placeEditController,
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
                            updateuserDetails(
                                dataQ.id,
                                nameEditController.text.trim(),
                                ageEditController.text.trim(),
                                phoneNumberEditController.text.trim(),
                                placeEditController.text.trim(),
                                context.read<AuthProvider>().imageAvtr);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Updating Data'),
                              ),
                            );

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                            context.read<AuthProvider>().imageAvtr = '';
                          },
                          child: const Text('Edit Profile'),
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

  Widget imageUpdateprofile() {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Stack(
        children: [
          dataQ['image'] == ''
              ? Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTb8BlqSdIUw4FHxjvv1-q0o1L80gVBEYTKVnUr7g-vHvJGsdH-51TlaTd6qyP_qMNE1I&usqp=CAU",
                  fit: BoxFit.contain,
                  height: 250,
                  width: 250,
                )
              : Image.memory(
                  const Base64Decoder()
                      .convert(context.read<AuthProvider>().imageAvtr),
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          Positioned(
            left: 50,
            right: 50,
            top: 170,
            bottom: 0,
            // padding: const EdgeInsets.only(top: 150, left: 150),
            child: IconButton(
                onPressed: () {
                  context.read<AuthProvider>().showBottomSheetUI(context);
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 40,
                )),
          )
        ],
      ),
    );
  }
}
