import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../export.dart';

class GroupsRepoImp extends GroupsRepository {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get _groupsCollection => _firestore.collection('Groups');
  DocumentReference _groupDocument(String groudId) =>
      _groupsCollection.doc(groudId);

  CollectionReference _msgsCollection(String groudId) =>
      _groupDocument(groudId).collection('Messages');

  DocumentReference _msgDocument(String groudId, String msgId) =>
      _msgsCollection(groudId).doc(msgId);

  DocumentSnapshot lastGroupDoc;

  @override
  Future<List<Group>> fetchMyGroups(String userId, {int page}) async {
    var query = _groupsCollection
        .where('isPublic', isEqualTo: true)
        .where('members', arrayContains: userId)
        .orderBy('membersCount', descending: true)
        .limit(10);
    if (query != null && page != 1) {
      query = query.startAfterDocument(lastGroupDoc);
    }
    final docs = (await query.get()).docs;
    if (docs.isEmpty) return [];
    lastGroupDoc = docs.last;
    return docs.map((g) => Group.fromJson(g.data())).toList();
  }

  DocumentSnapshot lastSearchedGroupDoc;
  @override
  Future<List<Group>> fetchAllGroups({int page}) async {
    var query = _groupsCollection
        .where('isPublic', isEqualTo: true)
        .orderBy('membersCount', descending: true)
        .limit(20);

    if (query != null && page != 1) {
      query = query.startAfterDocument(lastGroupDoc);
    }

    final docs = (await query.get()).docs;
    if (docs.isEmpty) return [];
    lastGroupDoc = docs.last;
    return docs.map((g) => Group.fromJson(g.data())).toList();
  }

  @override
  Future<Group> getGroup(String id) async =>
      Group.fromJson((await _groupDocument(id).get()).data());

  @override
  Stream<List<Message>> msgsStream(String groupId, int offset) =>
      _msgsCollection(groupId)
          .orderBy('time', descending: true)
          .limit(offset)
          .snapshots()
          .map(
            (s) => [for (final g in s.docs) Message.fromJson(g.data())],
          );

  @override
  Stream<List<Message>> unseenMsgsStream(String groupId, String userId) =>
      _msgsCollection(groupId)
          .orderBy('time', descending: true)
          .where('seenBy', arrayContains: userId)
          .limit(10)
          .snapshots()
          .map(
            (s) => [for (final g in s.docs) Message.fromJson(g.data())],
          );
  @override
  Future<void> sendMessage(Message msg) => _msgDocument(msg.groupId, msg.id)
      .set(msg.toJson()..['time'] = FieldValue.serverTimestamp());

  @override
  Future<void> editMessage({
    @required String groupId,
    @required String msgId,
    @required String content,
  }) =>
      _msgDocument(groupId, msgId).update({'content': content});
  @override
  Future<void> deleteMessage({
    @required String groupId,
    @required String msgId,
  }) =>
      _msgDocument(groupId, msgId).delete();

  @override
  Future<void> joinOrLeaveGroup({
    @required String groupId,
    @required String userId,
    @required bool isMember,
  }) async {
    await _groupDocument(groupId).update({
      'members': isMember
          ? FieldValue.arrayRemove([userId])
          : FieldValue.arrayUnion([userId]),
      'membersCount': FieldValue.increment(isMember ? -1 : 1),
      'mutedFor': isMember
          ? FieldValue.arrayRemove([userId])
          : FieldValue.arrayUnion([userId]),
    });

    await _firestore.doc('users/$userId').update({
      'joinedGroups': isMember
          ? FieldValue.arrayRemove([groupId])
          : FieldValue.arrayUnion([groupId]),
    });
  }

  @override
  Future<void> muteOrUnmuteGroup({
    @required String groupId,
    @required String userId,
    @required bool isMuted,
  }) =>
      _groupDocument(groupId).update(
        {
          'mutedFor': isMuted
              ? FieldValue.arrayRemove([userId])
              : FieldValue.arrayUnion([userId]),
        },
      );

  @override
  Future<void> createGroup(Group group) =>
      _groupDocument(group.id).set(group.toJson());

  @override
  Future<void> editGroup(
          {@required String id,
          @required String name,
          @required String photoUrl}) =>
      _groupDocument(id).update({
        'name': name,
        'photoUrl': photoUrl,
        'nameIndexes': Group.indexName(name),
      });

  @override
  Future<void> blockUnblockUser({
    @required String groupId,
    @required String userId,
    @required bool isBlocked,
  }) =>
      _groupDocument(groupId).update(
        {
          'blockedUsers': isBlocked
              ? FieldValue.arrayRemove([userId])
              : FieldValue.arrayUnion([userId]),
        },
      );
  DocumentSnapshot lastMemDoc;
  @override
  Future<List<User>> fetchMembers(String groupId, int page) async {
    var query = _firestore
        .collection('users')
        .where('joinedGroups', arrayContains: groupId)
        .orderBy('lastTimeSeen', descending: true)
        .limit(20);

    if (lastMemDoc != null && page != 0) {
      query = query.startAfterDocument(lastMemDoc);
    }
    final docs = (await query.get()).docs;
    if (docs.isEmpty) return [];
    lastMemDoc = docs.last;
    return [for (final d in docs) User.fromJson(d.data())];
  }

  @override
  Future<void> readMsg({
    @required String groupId,
    @required String msgId,
    @required String userId,
  }) =>
      _msgDocument(groupId, msgId).update({
        'seenBy': FieldValue.arrayUnion([userId])
      });

  @override
  Future<List<Group>> groupsSearch(String query) async {
    final docs = await _groupsCollection
        .where('nameIndexes', arrayContains: query.toLowerCase())
        .orderBy('membersCount', descending: true)
        .limit(10)
        .get();

    return [for (final g in docs.docs) Group.fromJson(g.data())];
  }
}
