// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_app/models/users.dart';
import 'package:med_app/views/screen/home_screen.dart';
import 'package:med_app/views/screen/login_screen.dart';

import '../constants/colors.dart';

class AuthControllers extends GetxController {
  static AuthControllers instance = Get.find();

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  User get user => _user.value!;

  // ignore: non_constant_identifier_names
  File? get ProfilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  // create ImagePicker
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture',
          colorText: const Color(0xFFafd1e9));
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

// create method to upload image to firebase storage
  Future<String> uploadImage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profileImage')
        .child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

// create method to register user
  void signUpUser(
      String username, String email, String password, File image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await uploadImage(image);
        Users users = Users(
            email: email,
            name: username,
            uid: cred.user!.uid,
            profilePhoto: downloadUrl);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(users.toJson());
      } else {
        Get.snackbar('Error Creating Account', 'Please enter all the fields ');
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar('Error Logging In', 'Please enter all fields');
      }
    } catch (e) {
      Get.snackbar('Error Logging In', e.toString());
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
