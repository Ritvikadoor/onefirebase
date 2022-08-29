import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one_firebase/constant.dart';
import 'package:provider/provider.dart';

class GetUserData extends StatelessWidget {
  QueryDocumentSnapshot<Object?> dataQ;
  GetUserData({Key? key, required this.dataQ}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Column(
      children: [
        Container(
          child: Center(
              child: Text(dataQ['name'] +
                  "    ${dataQ['place']}" +
                  dataQ['age'].toString())),
        ),
      ],
    );
  }
}
