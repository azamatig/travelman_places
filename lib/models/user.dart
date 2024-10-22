import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String photoUrl;
  String displayName;
  Map followers;
  Map following;
  String posts;
  String bio;
  String phone;

  UserModel(
      {this.uid,
      this.email,
      this.photoUrl,
      this.displayName,
      this.followers,
      this.following,
      this.bio,
      this.posts,
      this.phone});

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['email'] = user.email;
    data['photoUrl'] = user.photoUrl;
    data['name'] = user.displayName;
    data['followers'] = user.followers;
    data['following'] = user.following;
    data['bio'] = user.bio;
    data['posts'] = user.posts;
    data['phone'] = user.phone;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.email = mapData['email'];
    this.photoUrl = mapData['photoUrl'];
    this.displayName = mapData['name'];
    this.followers = mapData['followers'];
    this.following = mapData['following'];
    this.bio = mapData['bio'];
    this.posts = mapData['posts'];
    this.phone = mapData['phone'];
  }

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data();
    return UserModel(
      uid: d['uid'],
      email: d['email'],
      photoUrl: d['photoUrl'],
      displayName: d['name'],
      followers: d['followers'],
      following: d['following'],
      bio: d['bio'],
      posts: d['posts'],
      phone: d['phone'],
    );
  }
}
