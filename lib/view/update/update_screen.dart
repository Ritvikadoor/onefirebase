import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_firebase/controller/auth_provider.dart';
import 'package:one_firebase/view/add/view_model/image_profile.dart';
import 'package:one_firebase/view/add/view_model/user_details_firebase.dart';
import 'package:one_firebase/view/home/home_screen.dart';
import 'package:provider/provider.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({Key? key, required this.dataQ}) : super(key: key);
  final QueryDocumentSnapshot<Object?> dataQ;
  final formkey = GlobalKey<FormState>();

  TextEditingController nameEditController = TextEditingController();
  TextEditingController ageEditController = TextEditingController();

  TextEditingController phoneNumberEditController = TextEditingController();
  TextEditingController placeEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameEditController.text = dataQ['name'];
    ageEditController.text = dataQ['age'];
    phoneNumberEditController.text = dataQ['phone number'];
    placeEditController.text = dataQ['place'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
              onPressed: () => context.read<AuthProvider>().signOut(),
              icon: const Icon(Icons.logout))
        ],
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
                      return ClipOval(child: imageprofile());
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
                                  return 'Please enter some text';
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
                                  return 'Please enter some text';
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
                                  return 'Please enter some text';
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
                                  return 'Please enter some text';
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
                            if (formkey.currentState!.validate()) {
                              ///////////////////////////////////////////
                              adduserDetails(
                                  nameEditController.text.trim(),
                                  int.parse(ageEditController.text.trim()),
                                  int.parse(
                                      phoneNumberEditController.text.trim()),
                                  placeEditController.text.trim(),
                                  context.read<AuthProvider>().imageAvtr);

                              ///////////////////////////////////////////

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                              context.read<AuthProvider>().imageAvtr = '';
                            }
                            //  onAddStudentButtonClicked(context);
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
}
