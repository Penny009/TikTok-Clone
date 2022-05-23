import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_app/constants/colors.dart';
import 'package:med_app/views/screen/confirm_screen.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return ConfirmScreen(
              videoFile: File(video.path),
              videoPath: video.path,
            );
          },
        ),
      );
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            backgroundColor: AppColors.starColor,
            children: [
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.gallery, context),
                child: Row(
                  children: const [
                    Icon(Icons.image),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Gallery', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () => pickVideo(ImageSource.camera, context),
                child: Row(
                  children: const [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 15,
                    ),
                    Text('Camera', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Row(
                  children: const [
                    Icon(Icons.remove),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionsDialog(context),
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                color: AppColors.starColor,
                borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'Add Video',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
