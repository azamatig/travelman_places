import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelman/models/comment.dart';
import 'package:travelman/models/message.dart';
import 'package:travelman/models/post_likes.dart';
import 'package:travelman/models/post_user.dart';
import 'package:travelman/models/user.dart';

class FirebaseProvider {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel user;
  Post post;
  Like like;
  Message _message;
  Comment comment;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  StorageReference _storageReference;

  Future<void> addDataToDb(auth.User currentUser) async {
    print("Inside addDataToDb Method");

    _firestore
        .collection("display_names")
        .doc(currentUser.displayName)
        .set({'displayName': currentUser.displayName});

    user = UserModel(
        uid: currentUser.uid,
        email: currentUser.email,
        displayName: currentUser.displayName,
        photoUrl: currentUser.photoURL,
        followers: {},
        following: {},
        bio: '',
        posts: '0',
        phone: '');

    //  Map<String, String> mapdata = Map<String, dynamic>();

    //  mapdata = user.toMap(user);

    return _firestore
        .collection("users")
        .doc(currentUser.uid)
        .set(user.toMap(user));
  }

  Future<bool> authenticateUser(auth.User user) async {
    print("Inside authenticateUser");
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = result.docs;

    if (docs.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<auth.User> getCurrentUser() async {
    auth.User currentUser;
    currentUser = await _auth.currentUser;
    print("EMAIL ID : ${currentUser.email}");
    return currentUser;
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<auth.User> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: _signInAuthentication.accessToken,
      idToken: _signInAuthentication.idToken,
    );

    final auth.User user =
        await _auth.signInWithCredential(credential) as auth.User;
    return user;
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    _storageReference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    StorageUploadTask storageUploadTask = _storageReference.putFile(imageFile);
    var url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    return url;
  }

  Future<void> addPostToDb(
      UserModel currentUser, String imgUrl, String caption, String location) {
    CollectionReference _collectionRef =
        _firestore.collection("users").doc(currentUser.uid).collection("posts");

    post = Post(
        currentUserUid: currentUser.uid,
        imgUrl: imgUrl,
        caption: caption,
        location: location,
        postOwnerName: currentUser.displayName,
        postOwnerPhotoUrl: currentUser.photoUrl,
        time: FieldValue.serverTimestamp());

    return _collectionRef.add(post.toMap(post));
  }

  Future<UserModel> retrieveUserDetails(auth.User user) async {
    DocumentSnapshot _documentSnapshot =
        await _firestore.collection("users").doc(user.uid).get();
    return UserModel.fromMap(_documentSnapshot.data());
  }

  Future<List<DocumentSnapshot>> retrieveUserPosts(String userId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(userId)
        .collection("posts")
        .get();
    return querySnapshot.docs;
  }

  Future<List<DocumentSnapshot>> fetchPostCommentDetails(
      DocumentReference reference) async {
    QuerySnapshot snapshot = await reference.collection("comments").get();
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> fetchPostLikeDetails(
      DocumentReference reference) async {
    print("REFERENCE : ${reference.path}");
    QuerySnapshot snapshot = await reference.collection("likes").get();
    return snapshot.docs;
  }

  Future<bool> checkIfUserLikedOrNot(
      String userId, DocumentReference reference) async {
    DocumentSnapshot snapshot =
        await reference.collection("likes").doc(userId).get();
    print('DOC ID : ${snapshot.reference.path}');
    return snapshot.exists;
  }

  Future<List<DocumentSnapshot>> retrievePosts(auth.User user) async {
    List<DocumentSnapshot> list = List<DocumentSnapshot>();
    List<DocumentSnapshot> updatedList = List<DocumentSnapshot>();
    QuerySnapshot querySnapshot;
    QuerySnapshot snapshot = await _firestore.collection("users").get();
    for (int i = 0; i < snapshot.docs.length; i++) {
      if (snapshot.docs[i].id != user.uid) {
        list.add(snapshot.docs[i]);
      }
    }
    for (var i = 0; i < list.length; i++) {
      querySnapshot = await list[i].reference.collection("posts").get();
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        updatedList.add(querySnapshot.docs[i]);
      }
    }
    // fetchSearchPosts(updatedList);
    print("UPDATED LIST LENGTH : ${updatedList.length}");
    return updatedList;
  }

  Future<List<String>> fetchAllUserNames(auth.User user) async {
    List<String> userNameList = List<String>();
    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        userNameList.add(querySnapshot.docs[i].data()['displayName']);
      }
    }
    print("USERNAMES LIST : ${userNameList.length}");
    return userNameList;
  }

  Future<String> fetchUidBySearchedName(String name) async {
    String uid;
    List<DocumentSnapshot> uidList = List<DocumentSnapshot>();

    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      uidList.add(querySnapshot.docs[i]);
    }

    print("UID LIST : ${uidList.length}");

    for (var i = 0; i < uidList.length; i++) {
      if (uidList[i].data()['displayName'] == name) {
        uid = uidList[i].id;
      }
    }
    print("UID DOC ID: ${uid}");
    return uid;
  }

  Future<UserModel> fetchUserDetailsById(String uid) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("users").doc(uid).get();
    return UserModel.fromMap(documentSnapshot.data());
  }

  Future<void> followUser(
      {String currentUserId, String followingUserId}) async {
    var followingMap = Map<String, String>();
    followingMap['uid'] = followingUserId;
    await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(followingUserId)
        .set(followingMap);

    var followersMap = Map<String, String>();
    followersMap['uid'] = currentUserId;

    return _firestore
        .collection("users")
        .doc(followingUserId)
        .collection("followers")
        .doc(currentUserId)
        .set(followersMap);
  }

  Future<void> unFollowUser(
      {String currentUserId, String followingUserId}) async {
    await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .doc(followingUserId)
        .delete();

    return _firestore
        .collection("users")
        .doc(followingUserId)
        .collection("followers")
        .doc(currentUserId)
        .delete();
  }

  Future<bool> checkIsFollowing(String name, String currentUserId) async {
    bool isFollowing = false;
    String uid = await fetchUidBySearchedName(name);
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("following")
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id == uid) {
        isFollowing = true;
      }
    }
    return isFollowing;
  }

  Future<List<DocumentSnapshot>> fetchStats({String uid, String label}) async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("users").doc(uid).collection(label).get();
    return querySnapshot.docs;
  }

  Future<void> updatePhoto(String photoUrl, String uid) async {
    Map<String, dynamic> map = Map();
    map['photoUrl'] = photoUrl;
    return _firestore.collection("users").doc(uid).update(map);
  }

  Future<void> updateDetails(
      String uid, String name, String bio, String email, String phone) async {
    Map<String, dynamic> map = Map();
    map['displayName'] = name;
    map['bio'] = bio;
    map['email'] = email;
    map['phone'] = phone;
    return _firestore.collection("users").doc(uid).update(map);
  }

  Future<List<String>> fetchUserNames(auth.User user) async {
    DocumentReference documentReference =
        _firestore.collection("messages").doc(user.uid);
    List<String> userNameList = List<String>();
    List<String> chatUsersList = List<String>();
    QuerySnapshot querySnapshot = await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        print("USERNAMES : ${querySnapshot.docs[i].id}");
        userNameList.add(querySnapshot.docs[i].id);
        //querySnapshot.documents[i].reference.collection("collectionPath");
        //userNameList.add(querySnapshot.documents[i].data['displayName']);
      }
    }

    for (var i = 0; i < userNameList.length; i++) {
      if (documentReference.collection(userNameList[i]) != null) {
        if (documentReference.collection(userNameList[i]).get() != null) {
          print("CHAT USERS : ${userNameList[i]}");
          chatUsersList.add(userNameList[i]);
        }
      }
    }

    print("CHAT USERS LIST : ${chatUsersList.length}");

    return chatUsersList;

    // print("USERNAMES LIST : ${userNameList.length}");
    // return userNameList;
  }

  Future<List<UserModel>> fetchAllUsers(auth.User user) async {
    List<UserModel> userList = List<UserModel>();
    QuerySnapshot querySnapshot =
        await _firestore.collection("users").get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != user.uid) {
        userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));
        //userList.add(querySnapshot.documents[i].data[User.fromMap(mapData)]);
      }
    }
    print("USERSLIST : ${userList.length}");
    return userList;
  }

  void uploadImageMsgToDb(String url, String receiverUid, String senderuid) {
    _message = Message.withoutMessage(
        receiverUid: receiverUid,
        senderUid: senderuid,
        photoUrl: url,
        timestamp: FieldValue.serverTimestamp(),
        type: 'image');
    var map = Map<String, dynamic>();
    map['senderUid'] = _message.senderUid;
    map['receiverUid'] = _message.receiverUid;
    map['type'] = _message.type;
    map['timestamp'] = _message.timestamp;
    map['photoUrl'] = _message.photoUrl;

    print("Map : ${map}");
    _firestore
        .collection("messages")
        .doc(_message.senderUid)
        .collection(receiverUid)
        .add(map)
        .whenComplete(() {
      print("Messages added to db");
    });

    _firestore
        .collection("messages")
        .doc(receiverUid)
        .collection(_message.senderUid)
        .add(map)
        .whenComplete(() {
      print("Messages added to db");
    });
  }

  Future<void> addMessageToDb(Message message, String receiverUid) async {
    print("Message : ${message.message}");
    var map = message.toMap();

    print("Map : $map");
    await _firestore
        .collection("messages")
        .doc(message.senderUid)
        .collection(receiverUid)
        .add(map);

    return _firestore
        .collection("messages")
        .doc(receiverUid)
        .collection(message.senderUid)
        .add(map);
  }

  Future<List<DocumentSnapshot>> fetchFeed(auth.User user) async {
    List<String> followingUIDs = List<String>();
    List<DocumentSnapshot> list = List<DocumentSnapshot>();

    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("following")
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      followingUIDs.add(querySnapshot.docs[i].id);
    }

    print("FOLLOWING UIDS : ${followingUIDs.length}");

    for (var i = 0; i < followingUIDs.length; i++) {
      print("SDDSSD : ${followingUIDs[i]}");

      //retrievePostByUID(followingUIDs[i]);
      // fetchUserDetailsById(followingUIDs[i]);

      QuerySnapshot postSnapshot = await _firestore
          .collection("users")
          .doc(followingUIDs[i])
          .collection("posts")
          .get();
      // postSnapshot.documents;
      for (var i = 0; i < postSnapshot.docs.length; i++) {
        print("dad : ${postSnapshot.docs[i].id}");
        list.add(postSnapshot.docs[i]);
        print("ads : ${list.length}");
      }
    }

    return list;
  }

  Future<List<String>> fetchFollowingUids(auth.User user) async {
    List<String> followingUIDs = List<String>();

    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("following")
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      followingUIDs.add(querySnapshot.docs[i].id);
    }

    for (var i = 0; i < followingUIDs.length; i++) {
      print("DDDD : ${followingUIDs[i]}");
    }
    return followingUIDs;
  }
}
