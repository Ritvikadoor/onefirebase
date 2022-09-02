import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_firebase/constant.dart';
import 'package:one_firebase/auth_screen/controller/auth_provider.dart';
import 'package:one_firebase/add_screen/view/profile.dart';
import 'package:one_firebase/routes/routs.dart';
import 'package:one_firebase/update_screen/update_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              RoutesProvider.removeScreenUntil(screen: ScreenAdd()),
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
                icon: const Icon(Icons.logout))
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
                    ? ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final dataQ = snapshot.data!.docs[index];

                          return GestureDetector(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    RoutesProvider.removeScreen(
                                        screen: UpdateScreen(dataQ: dataQ));
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
                                    trailing: Text(dataQ['age'].toString()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ),
      ),
    );
  }
}
