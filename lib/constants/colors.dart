// import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:med_app/controllers/auth_controllers.dart';

class AppColors {
  static const Color textColor1 = Color(0xFF989acd);
  static const Color textColor2 = Color(0xFF878593);
  static const Color bigTextColor = Color(0xFF2e2e31);
  static const Color mainColor = Color(0xFF5d69b3);
  static const Color starColor = Color(0xFFe7bb4e);
  static const Color mainTextColor = Color(0xFFababad);
  static const Color buttonBackground = Color(0xFFf1f1f9);
  static const backgroundColor = Colors.black;
  static const borderColor = Colors.grey;
}

final authControlers = AuthControllers.instance;
final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;
