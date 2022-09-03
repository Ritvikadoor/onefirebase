import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:one_firebase/constant.dart';
import 'package:one_firebase/view/add_screen/profile.dart';
import 'package:one_firebase/controller/auth_controller/controller/auth_provider.dart';
import 'package:one_firebase/view/login_screen/signin_screen.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:one_firebase/view/update_screen/update_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.read<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return EmailPasswordLogin();
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => RoutesProvider.nextScreen(screen: ScreenAdd()),
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthProvider>().signOut();
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            body: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(
                          FirebaseAuth.instance.currentUser!.email.toString())
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.docs.isNotEmpty
                            ? ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final dataQ = snapshot.data!.docs[index];
                                  print(dataQ);
                                  return Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            RoutesProvider.nextScreen(
                                                screen:
                                                    UpdateScreen(dataQ: dataQ));
                                          },
                                          child: ListTile(
                                            title: Text(dataQ['name']),
                                            subtitle: Text(dataQ['place']),
                                            leading: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: MemoryImage(
                                                const Base64Decoder().convert(
                                                    dataQ['image'] == ''
                                                        ? tempImage
                                                        : dataQ['image']),
                                              ),
                                            ),
                                            trailing:
                                                Text(dataQ['age'].toString()),
                                          )),
                                    ],
                                  );
                                },
                              )
                            : Container(
                                child: Center(
                                    child: Lottie.network(
                                        'https://assets9.lottiefiles.com/packages/lf20_g4wqji2g.json')),
                              )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
            ),
          );
        });
  }
}
