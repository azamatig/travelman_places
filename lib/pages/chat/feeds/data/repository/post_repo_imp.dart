import 'package:cloud_firestore/cloud_firestore.dart';
import '../../export.dart';

class PostRepoImp extends PostRepository {
  static final _firestore = FirebaseFirestore.instance;

  CollectionReference get _postsCollection => _firestore.collection('posts');
  DocumentReference _postDocument(String postId) =>
      _postsCollection.doc(postId);
  CollectionReference _commentsCollection(String postId) =>
      _postDocument(postId).collection('comments');
  DocumentReference _commentDocument(String postId, String commentId) =>
      _commentsCollection(postId).doc(commentId);

  //SECTION ------------------------------Posts
  DocumentSnapshot lastPostDoc;
  @override
  Future<List<Post>> fetchPosts(
      PostQuery postQuery, String userId, int page) async {
    var col = _postsCollection.limit(10);

    postQuery.when(
      newest: () {
        col = col.orderBy('publishDate', descending: true);
      },
      gallery: () {
        col = col
            .where('hasImage', isEqualTo: true)
            .orderBy('publishDate', descending: true);
      },
      myPosts: () {
        col = col
            .where('authorId', isEqualTo: userId)
            .orderBy('publishDate', descending: true);
      },
      myFavorites: () {
        col = col
            .where('usersLikes', arrayContains: userId)
            .orderBy('publishDate', descending: true);
      },
    );
    if (page != 0 && lastPostDoc != null) {
      col = col.startAfterDocument(lastPostDoc);
    }
    final docs = (await col.get()).docs;
    if (docs.isNotEmpty) lastPostDoc = docs.last;
    return docs
        .map((s) => Post.fromJson(s.data()))
        .where((p) => !p.reportUsers.contains(userId))
        .toList();
  }

  @override
  Stream<Post> singlePostStream(String postId) {
    return _postDocument(postId).snapshots().map(
          (s) => Post.fromJson(s.data()),
        );
  }

  @override
  Stream<List<Post>> getUserPostsStream(String userId, int offset) {
    return _firestore
        .collection('posts')
        .where('authorId', isEqualTo: userId)
        .limit(offset)
        .orderBy('publishDate', descending: true)
        .snapshots()
        .map(
          (s) => [for (final d in s.docs) Post.fromJson(d.data())],
        );
  }

  @override
  Future<void> addPost(Post post) async {
    await _postDocument(post.id).set(post.toJson());
    await _firestore.doc('users/${post.authorId}').update(
      {
        'posts': FieldValue.arrayUnion([post.id])
      },
    );
  }

  @override
  Future<void> updatePost(String postId, String content, String imgUrl) {
    return _postDocument(postId).update({
      'content': content,
      'imgUrl': imgUrl,
      'updatedDate': FieldValue.serverTimestamp(),
      'hasImage': imgUrl?.isNotEmpty == true
    });
  }

  @override
  Future<void> removePost(
      String postId, String authorId, List<String> comments) async {
    await _postDocument(postId).delete();
    for (final id in (comments ?? [])) {
      await _commentDocument(postId, id).delete();
    }
    await _firestore.doc('users/$authorId').update(
      {
        'posts': FieldValue.arrayRemove([postId])
      },
    );
  }

//SECTION ------------------------------Post Ractions

  @override
  Future<void> addPostReaction(String postId, String userId) {
    return _postDocument(postId).update({
      'usersLikes': FieldValue.arrayUnion([userId]),
      'likesCount': FieldValue.increment(1),
    });
  }

  @override
  Future<void> removePostReaction(String postId, String userId) =>
      _postDocument(postId).update({
        'usersLikes': FieldValue.arrayRemove([userId]),
        'likesCount': FieldValue.increment(-1),
      });

//SECTION ------------------------------Post Report

  @override
  Future<void> reportPost(Post post, String currentUserId) async {
    await _firestore
        .collection('ReportedPosts')
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(post.toJson()..['reportedBy'] = currentUserId);
    await _postDocument(post.id).update({
      'reportUsers': FieldValue.arrayUnion([currentUserId])
    });
  }
}
