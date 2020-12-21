import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../../export.dart';

class CommentRepoImp implements CommentRepository {
  static final _firestore = FirebaseFirestore.instance;

  CollectionReference get _postsCollection => _firestore.collection('posts');

  DocumentReference _postDocument(String postId) =>
      _postsCollection.doc(postId);

  CollectionReference get _commentsCollection =>
      _firestore.collection('comments');
  DocumentReference _commentDocument(String commentId) =>
      _commentsCollection.doc(commentId);

  @override
  Stream<List<Comment>> commentsStream(String postId, int offset) {
    return _commentsCollection
        .where('postId', isEqualTo: postId)
        .orderBy('publishDate', descending: true)
        .limit(offset)
        .snapshots()
        .map(
          (s) => [for (final d in s.docs) Comment.fromJson(d.data())],
        )
        .handleError((e) {
      Logger().e('postCommentsStream', e);
    });
  }

  @override
  Stream<Comment> singleCommentStream(String commentId) {
    return _commentDocument(commentId).snapshots().map(
          (s) => Comment.fromJson(s.data()),
        );
  }

  @override
  Future<void> addComment(Comment comment) async {
    await _commentsCollection
        .doc(comment.id)
        .set(comment.toJson()..['publishDate'] = FieldValue.serverTimestamp());
    await _postDocument(comment.postId).update(
      {
        'commentsIds': FieldValue.arrayUnion([comment.id]),
        'commentsCount': FieldValue.increment(1)
      },
    );
  }

  @override
  Future<void> updateComment(Comment comment) {
    return _commentsCollection.doc(comment.id).update(
      {'content': comment.content},
    );
  }

  @override
  Future<void> removeComment(String postId, String commentId) async {
    await _commentsCollection.doc(commentId).delete();
    await _postDocument(postId).update({
      'commentsIds': FieldValue.arrayRemove([commentId]),
      'commentsCount': FieldValue.increment(-1),
    });
  }

  @override
  Future<void> addCommentReply(String commentId, Comment reply) {
    return _commentsCollection.doc(commentId).update(
      {
        'replyComments': FieldValue.arrayUnion([reply.toJson()]),
        'replyCount': FieldValue.increment(1),
      },
    );
  }

  @override
  Future<void> removeCommentReply(String commentId, Comment reply) {
    return _commentsCollection.doc(commentId).update({
      'replyComments': FieldValue.arrayRemove([reply.toJson()]),
      'replyCount': FieldValue.increment(-1),
    });
  }

  @override
  Future<void> addCommentReaction(Comment comment, String userId) =>
      _commentDocument(comment.id).update({
        'usersLikeIds': FieldValue.arrayUnion([userId])
      });

  @override
  Future<void> removeCommentReaction(Comment comment, String userId) =>
      _commentDocument(comment.id).update({
        'usersLikeIds': FieldValue.arrayRemove([userId])
      });
}
