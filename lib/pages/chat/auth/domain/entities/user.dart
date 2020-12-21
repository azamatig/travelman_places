import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends _User with _$User {
  final String id, email, phoneNumber, country, gender;
  final bool isOnline;

  @JsonKey(defaultValue: false)
  final bool isBanned;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime lastTimeSeen;

  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime accountCreationTime;

  @JsonKey(defaultValue: <String>[])
  final List<String> reporters;

  @JsonKey(defaultValue: <String>[])
  final List<String> registeredContacts;

  @JsonKey(defaultValue: <String>[])
  final List<String> otherContacts;

  @JsonKey(fromJson: _typeFromJson)
  final UserType userType;

  User({
    this.id,
    String name,
    this.email,
    this.phoneNumber,
    this.country,
    this.gender,
    String status,
    String photoUrl,
    this.lastTimeSeen,
    this.isOnline,
    this.isBanned,
    bool onlineStatus,
    bool chatNotify,
    bool groupsNotify,
    List<String> posts,
    List<String> followers,
    List<String> following,
    List<String> blockedUsers,
    this.reporters,
    this.accountCreationTime,
    this.userType,
    this.registeredContacts,
    this.otherContacts,
  }) : super(
          name: name,
          status: status,
          photoUrl: photoUrl,
          posts: ObservableList<String>.of(posts ?? []),
          followers: ObservableList<String>.of(followers ?? []),
          following: ObservableList<String>.of(following ?? []),
          blockedUsers: ObservableList<String>.of(blockedUsers ?? []),
          onlineStatus: onlineStatus ?? true,
          chatNotify: chatNotify ?? true,
          groupsNotify: groupsNotify ?? true,
        );

  factory User.createNew({
    @required String uid,
    @required String phone,
    String name,
    String country,
    String photoUrl,
    String email,
    String status,
    String gender,
  }) {
    return User(
      id: uid,
      name: name ?? 'Otaku-${Random().nextInt(10000)}',
      email: email ?? '',
      photoUrl: photoUrl ?? '',
      status: status ?? '',
      phoneNumber: phone,
      country: country,
      gender: gender,
      isOnline: true,
      isBanned: false,
      lastTimeSeen: DateTime.now(),
      accountCreationTime: DateTime.now(),
      posts: <String>[],
      followers: <String>[],
      following: <String>[],
      blockedUsers: <String>[],
      reporters: [],
      onlineStatus: true,
      chatNotify: true,
      groupsNotify: true,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime _timeFromJson(ts) =>
      ts is DateTime ? ts : (ts as Timestamp)?.toDate();
  static DateTime _timeToJson(DateTime time) => time;

  static UserType _typeFromJson(String t) => userTypefromString(t);

  bool get isSuperAdmin => userType == UserType.SuperAdmin;
  bool get isAdmin => [UserType.Admin, UserType.SuperAdmin].contains(userType);
}

abstract class _User with Store {
  @observable
  String name;

  @observable
  String status;

  @observable
  String photoUrl;

  @observable
  bool onlineStatus;

  @observable
  bool chatNotify;

  @observable
  bool groupsNotify;

  @observable
  ObservableList<String> posts;

  @observable
  ObservableList<String> followers;

  @observable
  ObservableList<String> following;

  @observable
  ObservableList<String> blockedUsers;

  _User({
    this.name,
    this.status,
    this.photoUrl,
    this.posts,
    this.followers,
    this.following,
    this.blockedUsers,
    this.onlineStatus,
    this.chatNotify,
    this.groupsNotify,
  });
}

enum UserType {
  SuperAdmin,
  Admin,
  Normal,
}

UserType userTypefromString(String s) {
  switch (s) {
    case 'SuperAdmin':
      return UserType.SuperAdmin;
    case 'Admin':
      return UserType.Admin;
    default:
      return UserType.Normal;
  }
}
