// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:med_app/constants/colors.dart';
import 'package:med_app/views/screen/profile_screen.dart';
import 'package:med_app/views/screen/search_screen.dart';
import 'package:med_app/views/screen/video_screen.dart';
import 'package:med_app/views/screen/add_video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List pages = [
    VideoScreen(),
    SearchScreen(),
    const AddVideoScreen(),
    ProfileScreen(uid: authControlers.user.uid)
  ];

  void tap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: currentIndex,
        onTap: tap,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
