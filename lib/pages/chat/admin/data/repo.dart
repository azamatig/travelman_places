import 'package:cloud_firestore/cloud_firestore.dart';
import '../export.dart';

class AdminRepo {
  static final _firestore = FirebaseFirestore.instance;

  // CollectionReference get _postsCollection => _firestore.collection('posts');
  // DocumentReference _postDocument(String postId) =>
  //     _postsCollection.doc(postId);

  Stream<List<Post>> reportedPostsStream() {
    return _firestore
        .collection('ReportedPosts')
        .orderBy('id', descending: true)
        .snapshots()
        .map(
          (s) => [for (final d in s.docs) Post.fromJson(d.data())],
        );
  }

  Stream<List<Chat>> chatsStream(int offset) => FirebaseFirestore.instance
      .collection('chats')
      .orderBy('updateTime', descending: true)
      .limit(offset)
      .snapshots()
      .map(
        (s) => [for (final doc in s.docs) Chat.fromJson(doc.data())],
      );
  Future<void> unReportPost(String postId) =>
      _firestore.doc('ReportedPosts/$postId').delete();
}
