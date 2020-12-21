import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../export.dart';

part 'controller.g.dart';

class ConversationCon = _ConversationCon
    with _$ConversationCon
    implements Disposable;

abstract class _ConversationCon with Store {
  final Group group;
  _ConversationCon(this.group) {
    isMember = group.members.contains(currentUser.id);
    isMuted = group.mutedFor.contains(currentUser.id);
  }

  final repo = Modular.get<GroupsRepository>();
  final refreshController = RefreshController(initialRefresh: false);
  final scrollController =
      ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

  Stream<List<Message>> get msgsStream => repo.msgsStream(group.id, msgsOffset);

  User get currentUser => Modular.get<AuthController>().currentUser;

  ObservableList<Message> msgs = ObservableList<Message>();

  @observable
  int msgsOffset = 20;

  @computed
  bool get isAdmin => group.admins.contains(currentUser.id);

  @observable
  bool isMember;

  @observable
  bool isMuted;

  @action
  Future<void> onRefreshLoading() async {
    msgsOffset = msgs.length + 10;
    await Future.delayed(Duration(seconds: 2));
    refreshController.loadComplete();
  }

  Future<void> editMessage({String msgId, String content}) =>
      repo.editMessage(groupId: group.id, msgId: msgId, content: content);

  Future<void> deleteMessage({String msgId}) =>
      repo.deleteMessage(groupId: group.id, msgId: msgId);

  @action
  Future<void> joinOrLeaveGroup() async {
    try {
      isMember
          ? group.members.remove(currentUser.id)
          : group.members.add(currentUser.id);
      isMember = !isMember;
      await repo.joinOrLeaveGroup(
        groupId: group.id,
        userId: currentUser.id,
        isMember: !isMember,
      );
    } catch (e, s) {
      Logger().e(e);
    }
  }

  @action
  Future<void> muteOrUnmuteGroup() async {
    try {
      isMuted
          ? group.mutedFor.remove(currentUser.id)
          : group.mutedFor.add(currentUser.id);
      isMuted = !isMuted;
      await repo.muteOrUnmuteGroup(
        groupId: group.id,
        userId: currentUser.id,
        isMuted: !isMuted,
      );
    } catch (e, s) {
      Logger().e(e);
    }
  }

  @action
  void mergeMsgs(List<Message> otherMsgs) {
    final currentMsgs = [...msgs];
    final msgsId = [for (final m in currentMsgs) m.id];
    for (var i = 0; i < otherMsgs.length; i++) {
      final msg = otherMsgs[i];
      if (!msgsId.contains(msg.id)) {
        currentMsgs.add(msg);
      }
    }

    msgs =
        (currentMsgs..sort((a, b) => b.time.compareTo(a.time))).asObservable();
  }

  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
  }
}
