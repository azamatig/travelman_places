// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    id: json['id'] as String,
    isPublic: json['isPublic'] as bool,
    name: json['name'] as String,
    nameIndexes:
        (json['nameIndexes'] as List)?.map((e) => e as String)?.toList(),
    photoUrl: json['photoUrl'] as String,
    admins: (json['admins'] as List)?.map((e) => e as String)?.toList(),
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
    mutedFor: (json['mutedFor'] as List)?.map((e) => e as String)?.toList(),
    blockedUsers:
        (json['blockedUsers'] as List)?.map((e) => e as String)?.toList(),
    membersCount: json['membersCount'] as int,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'admins': instance.admins?.toList(),
      'members': instance.members?.toList(),
      'mutedFor': instance.mutedFor?.toList(),
      'blockedUsers': instance.blockedUsers?.toList(),
      'id': instance.id,
      'isPublic': instance.isPublic,
      'membersCount': instance.membersCount,
      'nameIndexes': instance.nameIndexes,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Group on _Group, Store {
  final _$nameAtom = Atom(name: '_Group.name');

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

  final _$photoUrlAtom = Atom(name: '_Group.photoUrl');

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

  @override
  String toString() {
    return '''
name: ${name},
photoUrl: ${photoUrl}
    ''';
  }
}
