import 'package:meta/meta.dart';
import '../../export.dart';

abstract class GroupsRepository {
  Future<List<Group>> fetchMyGroups(String userId, {int page});
  Future<List<Group>> fetchAllGroups( {int page});
  Future<Group> getGroup(String id);

  Stream<List<Message>> msgsStream(String groupId, int offset);
  Stream<List<Message>> unseenMsgsStream(String groupId, String userId);

  Future<void> sendMessage(Message msg);

  Future<void> editMessage({
    @required String groupId,
    @required String msgId,
    @required String content,
  });
  Future<void> deleteMessage({
    @required String groupId,
    @required String msgId,
  });
  Future<void> joinOrLeaveGroup({
    @required String groupId,
    @required String userId,
    @required bool isMember,
  });

  Future<void> muteOrUnmuteGroup({
    @required String groupId,
    @required String userId,
    @required bool isMuted,
  });

  Future<void> createGroup(Group group);
  Future<void> editGroup(
      {@required String id, @required String name, @required String photoUrl});

  Future<void> blockUnblockUser({
    @required String groupId,
    @required String userId,
    @required bool isBlocked,
  });
  Future<List<User>> fetchMembers(String groupId, int page);
  Future<void> readMsg({
    @required String groupId,
    @required String msgId,
    @required String userId,
  });

  Future<List<Group>> groupsSearch(String query);
}
