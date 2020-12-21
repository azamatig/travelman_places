import '../../export.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPosts(PostQuery postQuery, String userId, int page);
  Stream<Post> singlePostStream(String postId);

  Stream<List<Post>> getUserPostsStream(String id, int offset);
  Future<void> addPost(Post post);
  Future<void> updatePost(String postId, String content, String imgUrl);
  Future<void> removePost(
      String postId, String authorId, List<String> comments);

  Future<void> addPostReaction(String postId, String userID);
  Future<void> removePostReaction(String postId, String userID);

  Future<void> reportPost(Post post, String currentUserId);
}
