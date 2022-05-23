import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String profilePhoto;
  String thumbnail;

  Video(
      {required this.caption,
      required this.commentCount,
      required this.profilePhoto,
      required this.shareCount,
      required this.songName,
      required this.thumbnail,
      required this.videoUrl,
      required this.username,
      required this.likes,
      required this.uid,
      required this.id});

  Map<String, dynamic> toJson() => {
        'username': username,
        'id': id,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'songName': songName,
        'thumbnail': thumbnail,
        'likes': likes,
        'uid': uid,
        'profilePhoto': profilePhoto,
        'caption': caption,
        'videoUrl': videoUrl,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        caption: snapshot['caption'],
        commentCount: snapshot['commentCount'],
        profilePhoto: snapshot['profilePhoto'],
        shareCount: snapshot['shareCount'],
        songName: snapshot['songName'],
        thumbnail: snapshot['thumbnail'],
        videoUrl: snapshot['videoUrl'],
        username: snapshot['username'],
        likes: snapshot['likes'],
        uid: snapshot['uid'],
        id: snapshot['id']);
  }
}
