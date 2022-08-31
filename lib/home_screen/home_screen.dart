import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_firebase/constant.dart';
import 'package:one_firebase/controller/auth_provider.dart';
import 'package:one_firebase/view/add/profile.dart';
import 'package:one_firebase/view/update/update_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ScreenAdd())),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FirebaseAuth.instance.currentUser!.email.toString())
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final dataQ = snapshot.data!.docs[index];
                        //final id = snapshot.data!.docs[index];
                        return GestureDetector(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateScreen(dataQ: dataQ)));
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
    );
  }
}
