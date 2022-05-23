import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:med_app/constants/colors.dart';
import 'package:med_app/models/videos.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoControllers extends GetxController {
  // create thumbnails for uploaded image
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // compress video using video_compress plugin
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  //upload videos to storage
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload videos to firestore
  uploadVideos(String songName, String caption, String videoPath) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      var allDocs = await firestore.collection('videos').get();
      int lens = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage('Video $lens', videoPath);
      String thumbnail = await _uploadImageToStorage('Video $lens', videoPath);
      Video video = Video(
        caption: caption,
        commentCount: 0,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
        shareCount: 0,
        songName: songName,
        thumbnail: thumbnail,
        videoUrl: videoUrl,
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        likes: [],
        uid: uid,
        id: 'Video $lens',
      );
      await firestore
          .collection('videos')
          .doc('Video $lens')
          .set(video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString());
    }
  }
}
