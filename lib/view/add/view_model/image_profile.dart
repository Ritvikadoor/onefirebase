import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one_firebase/controller/auth_provider.dart';
import 'package:provider/provider.dart';

Widget imageprofile() {
  return Consumer<AuthProvider>(
    builder: (context, value, child) => Stack(
      children: [
        value.imageAvtr.trim().isEmpty
            ? Image.network(
                "https://pbs.twimg.com/media/Dm1neA0X4AEMmnR.jpg:large",
                fit: BoxFit.contain,
                height: 250,
                width: 250,
              )
            : Image.memory(
                const Base64Decoder().convert(value.imageAvtr),
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
