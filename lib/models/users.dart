import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String name;
  String profilePhoto;
  String email;
  String uid;

  Users({
    required this.email,
    required this.name,
    required this.uid,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'profilePhoto': profilePhoto,
        'email': email,
        'uid': uid,
      };

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Users(
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto']);
  }
}
