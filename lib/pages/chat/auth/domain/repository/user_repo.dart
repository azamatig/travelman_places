import '../../export.dart';

abstract class UserRepository {
  Future<User> fetchUserData(String userId);

  Future<User> registerUser({
    String username,
    String email,
    String gender,
    String photoUrl,
    String status,
  });

  Stream<List<User>> onlineUsers();

  Future<void> setUserAsActive(String userId, bool isActive);

  Stream<User> getUserStream(String userID);

  Future<void> updateUseInfo(User user);

  Future<void> followUser(String currentUserId, String otherId);

  Future<void> unFollowUser(String currentUserId, String otherId);

  Future<void> updateBlockedUsers(
      String currentUserId, List<String> blockedUsers);
  Future<bool> checkIfUserExist(String uid);
  Future<bool> checkIfUsernameTaken(String username);
  Future<void> banUser(String userId);
}
