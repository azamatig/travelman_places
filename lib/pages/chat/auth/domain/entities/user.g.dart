// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    country: json['country'] as String,
    gender: json['gender'] as String,
    status: json['status'] as String,
    photoUrl: json['photoUrl'] as String,
    lastTimeSeen: User._timeFromJson(json['lastTimeSeen']),
    isOnline: json['isOnline'] as bool,
    isBanned: json['isBanned'] as bool ?? false,
    onlineStatus: json['onlineStatus'] as bool,
    chatNotify: json['chatNotify'] as bool,
    groupsNotify: json['groupsNotify'] as bool,
    posts: (json['posts'] as List)?.map((e) => e as String)?.toList(),
    followers: (json['followers'] as List)?.map((e) => e as String)?.toList(),
    following: (json['following'] as List)?.map((e) => e as String)?.toList(),
    blockedUsers:
        (json['blockedUsers'] as List)?.map((e) => e as String)?.toList(),
    reporters:
        (json['reporters'] as List)?.map((e) => e as String)?.toList() ?? [],
    accountCreationTime: User._timeFromJson(json['accountCreationTime']),
    userType: User._typeFromJson(json['userType'] as String),
    registeredContacts: (json['registeredContacts'] as List)
            ?.map((e) => e as String)
            ?.toList() ??
        [],
    otherContacts:
        (json['otherContacts'] as List)?.map((e) => e as String)?.toList() ??
            [],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'photoUrl': instance.photoUrl,
      'onlineStatus': instance.onlineStatus,
      'chatNotify': instance.chatNotify,
      'groupsNotify': instance.groupsNotify,
      'posts': instance.posts,
      'followers': instance.followers,
      'following': instance.following,
      'blockedUsers': instance.blockedUsers,
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'country': instance.country,
      'gender': instance.gender,
      'isOnline': instance.isOnline,
      'isBanned': instance.isBanned,
      'lastTimeSeen': User._timeToJson(instance.lastTimeSeen),
      'accountCreationTime': User._timeToJson(instance.accountCreationTime),
      'reporters': instance.reporters,
      'registeredContacts': instance.registeredContacts,
      'otherContacts': instance.otherContacts,
      'userType': _$UserTypeEnumMap[instance.userType],
    };

const _$UserTypeEnumMap = {
  UserType.SuperAdmin: 'SuperAdmin',
  UserType.Admin: 'Admin',
  UserType.Normal: 'Normal',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$User on _User, Store {
  final _$nameAtom = Atom(name: '_User.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$statusAtom = Atom(name: '_User.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$photoUrlAtom = Atom(name: '_User.photoUrl');

  @override
  String get photoUrl {
    _$photoUrlAtom.reportRead();
    return super.photoUrl;
  }

  @override
  set photoUrl(String value) {
    _$photoUrlAtom.reportWrite(value, super.photoUrl, () {
      super.photoUrl = value;
    });
  }

  final _$onlineStatusAtom = Atom(name: '_User.onlineStatus');

  @override
  bool get onlineStatus {
    _$onlineStatusAtom.reportRead();
    return super.onlineStatus;
  }

  @override
  set onlineStatus(bool value) {
    _$onlineStatusAtom.reportWrite(value, super.onlineStatus, () {
      super.onlineStatus = value;
    });
  }

  final _$chatNotifyAtom = Atom(name: '_User.chatNotify');

  @override
  bool get chatNotify {
    _$chatNotifyAtom.reportRead();
    return super.chatNotify;
  }

  @override
  set chatNotify(bool value) {
    _$chatNotifyAtom.reportWrite(value, super.chatNotify, () {
      super.chatNotify = value;
    });
  }

  final _$groupsNotifyAtom = Atom(name: '_User.groupsNotify');

  @override
  bool get groupsNotify {
    _$groupsNotifyAtom.reportRead();
    return super.groupsNotify;
  }

  @override
  set groupsNotify(bool value) {
    _$groupsNotifyAtom.reportWrite(value, super.groupsNotify, () {
      super.groupsNotify = value;
    });
  }

  final _$postsAtom = Atom(name: '_User.posts');

  @override
  ObservableList<String> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<String> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  final _$followersAtom = Atom(name: '_User.followers');

  @override
  ObservableList<String> get followers {
    _$followersAtom.reportRead();
    return super.followers;
  }

  @override
  set followers(ObservableList<String> value) {
    _$followersAtom.reportWrite(value, super.followers, () {
      super.followers = value;
    });
  }

  final _$followingAtom = Atom(name: '_User.following');

  @override
  ObservableList<String> get following {
    _$followingAtom.reportRead();
    return super.following;
  }

  @override
  set following(ObservableList<String> value) {
    _$followingAtom.reportWrite(value, super.following, () {
      super.following = value;
    });
  }

  final _$blockedUsersAtom = Atom(name: '_User.blockedUsers');

  @override
  ObservableList<String> get blockedUsers {
    _$blockedUsersAtom.reportRead();
    return super.blockedUsers;
  }

  @override
  set blockedUsers(ObservableList<String> value) {
    _$blockedUsersAtom.reportWrite(value, super.blockedUsers, () {
      super.blockedUsers = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
status: ${status},
photoUrl: ${photoUrl},
onlineStatus: ${onlineStatus},
chatNotify: ${chatNotify},
groupsNotify: ${groupsNotify},
posts: ${posts},
followers: ${followers},
following: ${following},
blockedUsers: ${blockedUsers}
    ''';
  }
}
