import '../../export.dart';

abstract class CommentRepository {
  Stream<List<Comment>> commentsStream(String postId, int offset);
  Stream<Comment> singleCommentStream(String commentId);
  Future<void> addComment(Comment comment);
  Future<void> updateComment(Comment comment);
  Future<void> removeComment(String postId, String commentId);
  Future<void> addCommentReply(String commentId, Comment reply);
  Future<void> removeCommentReply(String commentId, Comment reply);
  Future<void> addCommentReaction(Comment comment, String userId);
  Future<void> removeCommentReaction(Comment comment, String userId);
}
