import 'package:freezed_annotation/freezed_annotation.dart';
import '../../export.dart';

part 'user_navigation_tracker.freezed.dart';

@freezed
abstract class UserNavigationTracker with _$UserNavigationTracker {
  const factory UserNavigationTracker.onFeed() = _Feed;
  const factory UserNavigationTracker.commenting() = _Commenting;
  const factory UserNavigationTracker.posting() = _Posting;
  const factory UserNavigationTracker.onChatScreen() = _OnChatScreen;
  const factory UserNavigationTracker.chatting(String userId) = _Chatting;
  const factory UserNavigationTracker.groupChatting(Group group) =
      _GroupChatting;
}
