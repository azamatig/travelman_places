import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String ownerUid;
  String imgUrl;
  String caption;
  String location;
  Timestamp time;
  String postOwnerName;
  String postOwnerPhotoUrl;

  Post(
      {this.ownerUid,
      this.imgUrl,
      this.caption,
      this.location,
      this.time,
      this.postOwnerName,
      this.postOwnerPhotoUrl});

  Map toMap(Post post) {
    var data = Map<String, dynamic>();
    data['ownerUid'] = post.ownerUid;
    data['imgUrl'] = post.imgUrl;
    data['caption'] = post.caption;
    data['location'] = post.location;
    data['time'] = post.time;
    data['postOwnerName'] = post.postOwnerName;
    data['postOwnerPhotoUrl'] = post.postOwnerPhotoUrl;
    return data;
  }

  Post.fromMap(Map<String, dynamic> mapData) {
    this.ownerUid = mapData['ownerUid'];
    this.imgUrl = mapData['imgUrl'];
    this.caption = mapData['caption'];
    this.location = mapData['location'];
    this.time = mapData['time'];
    this.postOwnerName = mapData['postOwnerName'];
    this.postOwnerPhotoUrl = mapData['postOwnerPhotoUrl'];
  }

  factory Post.fromFirestore(DocumentSnapshot snapshot) {
    var d = snapshot.data();
    return Post(
      ownerUid: d['ownerUid'],
      imgUrl: d['imgUrl'],
      location: d['location'],
      caption: d['caption'],
      time: d['time'],
      postOwnerName: d['postOwnerName'],
      postOwnerPhotoUrl: d['postOwnerPhotoUrl'],
    );
  }
}
