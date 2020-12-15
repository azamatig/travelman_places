import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String photoUrl;
  String displayName;
  Map followers;
  Map following;
  List<String> blockedUsers;
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
      this.blockedUsers,
      this.bio,
      this.posts,
      this.phone});

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['email'] = user.email;
    data['image url'] = user.photoUrl;
    data['name'] = user.displayName;
    data['followers'] = user.followers;
    data['following'] = user.following;
    data['bio'] = user.bio;
    data['blockerUsers'] = user.blockedUsers;
    data['posts'] = user.posts;
    data['phone'] = user.phone;
    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.email = mapData['email'];
    this.photoUrl = mapData['image url'];
    this.displayName = mapData['name'];
    this.followers = mapData['followers'];
    this.following = mapData['following'];
    this.blockedUsers = mapData['blockedUsers'];
    this.bio = mapData['bio'];
    this.posts = mapData['posts'];
    this.phone = mapData['phone'];
  }

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data();
    return UserModel(
      uid: d['uid'],
      email: d['email'],
      photoUrl: d['image url'],
      displayName: d['name'],
      followers: d['followers'],
      following: d['following'],
      blockedUsers: d['blockedUsers'],
      bio: d['bio'],
      posts: d['posts'],
      phone: d['phone'],
    );
  }
}
