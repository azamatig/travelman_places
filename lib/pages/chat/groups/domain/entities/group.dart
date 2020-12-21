import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends _Group with _$Group {
  final String id;
  final bool isPublic;
  final int membersCount;
  final List<String> nameIndexes;

  Group({
    this.id,
    this.isPublic,
    String name,
    this.nameIndexes,
    String photoUrl,
    List<String> admins,
    List<String> members,
    List<String> mutedFor,
    List<String> blockedUsers,
    this.membersCount,
  }) : super(
          name: name,
          photoUrl: photoUrl,
          admins: (admins ?? []).toSet().asObservable(),
          members: (members ?? []).toSet().asObservable(),
          mutedFor: (mutedFor ?? []).toSet().asObservable(),
          blockedUsers: (blockedUsers ?? []).toSet().asObservable(),
        );

  factory Group.create(
      {@required String name,
      @required String userId,
      @required String imgUrl}) {
    return Group(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      admins: [userId],
      members: [userId],
      membersCount: 1,
      mutedFor: [],
      photoUrl: imgUrl,
      isPublic: true,
      nameIndexes: indexName(name),
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);

  static List<String> indexName(String name) {
    name = name.trim();
    final indices = <String>[];
    for (var i = 1; i < name.length; i++) {
      indices.add(name.substring(0, i).toLowerCase());
    }
    return indices;
  }
}

abstract class _Group with Store {
  @observable
  String name;

  @observable
  String photoUrl;

  ObservableSet<String> admins;

  ObservableSet<String> members;

  ObservableSet<String> mutedFor;

  ObservableSet<String> blockedUsers;

  _Group({
    this.name,
    this.photoUrl,
    this.admins,
    this.members,
    this.mutedFor,
    this.blockedUsers,
  });
}

extension GEx on _Group {
  bool isAdmin(String userId) => admins.contains(userId);
  bool isBlocked(String userId) => blockedUsers.contains(userId);
}
