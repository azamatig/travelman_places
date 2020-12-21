// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

class _$ChatTearOff {
  const _$ChatTearOff();

// ignore: unused_element
  _Chat call(
      {String id,
      List<String> users,
      List<String> visibleTo,
      String firstUserName,
      String otherUserName,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime updateTime,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime createdAt}) {
    return _Chat(
      id: id,
      users: users,
      visibleTo: visibleTo,
      firstUserName: firstUserName,
      otherUserName: otherUserName,
      updateTime: updateTime,
      createdAt: createdAt,
    );
  }
}

// ignore: unused_element
const $Chat = _$ChatTearOff();

mixin _$Chat {
  String get id;
  List<String> get users;
  List<String> get visibleTo;
  String get firstUserName;
  String get otherUserName;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get updateTime;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get createdAt;

  Map<String, dynamic> toJson();
  $ChatCopyWith<Chat> get copyWith;
}

abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call(
      {String id,
      List<String> users,
      List<String> visibleTo,
      String firstUserName,
      String otherUserName,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime updateTime,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime createdAt});
}

class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object id = freezed,
    Object users = freezed,
    Object visibleTo = freezed,
    Object firstUserName = freezed,
    Object otherUserName = freezed,
    Object updateTime = freezed,
    Object createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      users: users == freezed ? _value.users : users as List<String>,
      visibleTo:
          visibleTo == freezed ? _value.visibleTo : visibleTo as List<String>,
      firstUserName: firstUserName == freezed
          ? _value.firstUserName
          : firstUserName as String,
      otherUserName: otherUserName == freezed
          ? _value.otherUserName
          : otherUserName as String,
      updateTime:
          updateTime == freezed ? _value.updateTime : updateTime as DateTime,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
    ));
  }
}

abstract class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) then) =
      __$ChatCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      List<String> users,
      List<String> visibleTo,
      String firstUserName,
      String otherUserName,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime updateTime,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime createdAt});
}

class __$ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$ChatCopyWith<$Res> {
  __$ChatCopyWithImpl(_Chat _value, $Res Function(_Chat) _then)
      : super(_value, (v) => _then(v as _Chat));

  @override
  _Chat get _value => super._value as _Chat;

  @override
  $Res call({
    Object id = freezed,
    Object users = freezed,
    Object visibleTo = freezed,
    Object firstUserName = freezed,
    Object otherUserName = freezed,
    Object updateTime = freezed,
    Object createdAt = freezed,
  }) {
    return _then(_Chat(
      id: id == freezed ? _value.id : id as String,
      users: users == freezed ? _value.users : users as List<String>,
      visibleTo:
          visibleTo == freezed ? _value.visibleTo : visibleTo as List<String>,
      firstUserName: firstUserName == freezed
          ? _value.firstUserName
          : firstUserName as String,
      otherUserName: otherUserName == freezed
          ? _value.otherUserName
          : otherUserName as String,
      updateTime:
          updateTime == freezed ? _value.updateTime : updateTime as DateTime,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_Chat implements _Chat {
  const _$_Chat(
      {this.id,
      this.users,
      this.visibleTo,
      this.firstUserName,
      this.otherUserName,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) this.updateTime,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson) this.createdAt});

  factory _$_Chat.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatFromJson(json);

  @override
  final String id;
  @override
  final List<String> users;
  @override
  final List<String> visibleTo;
  @override
  final String firstUserName;
  @override
  final String otherUserName;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime updateTime;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime createdAt;

  @override
  String toString() {
    return 'Chat(id: $id, users: $users, visibleTo: $visibleTo, firstUserName: $firstUserName, otherUserName: $otherUserName, updateTime: $updateTime, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Chat &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.visibleTo, visibleTo) ||
                const DeepCollectionEquality()
                    .equals(other.visibleTo, visibleTo)) &&
            (identical(other.firstUserName, firstUserName) ||
                const DeepCollectionEquality()
                    .equals(other.firstUserName, firstUserName)) &&
            (identical(other.otherUserName, otherUserName) ||
                const DeepCollectionEquality()
                    .equals(other.otherUserName, otherUserName)) &&
            (identical(other.updateTime, updateTime) ||
                const DeepCollectionEquality()
                    .equals(other.updateTime, updateTime)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(users) ^
      const DeepCollectionEquality().hash(visibleTo) ^
      const DeepCollectionEquality().hash(firstUserName) ^
      const DeepCollectionEquality().hash(otherUserName) ^
      const DeepCollectionEquality().hash(updateTime) ^
      const DeepCollectionEquality().hash(createdAt);

  @override
  _$ChatCopyWith<_Chat> get copyWith =>
      __$ChatCopyWithImpl<_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatToJson(this);
  }
}

abstract class _Chat implements Chat {
  const factory _Chat(
      {String id,
      List<String> users,
      List<String> visibleTo,
      String firstUserName,
      String otherUserName,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime updateTime,
      @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
          DateTime createdAt}) = _$_Chat;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

  @override
  String get id;
  @override
  List<String> get users;
  @override
  List<String> get visibleTo;
  @override
  String get firstUserName;
  @override
  String get otherUserName;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get updateTime;
  @override
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  DateTime get createdAt;
  @override
  _$ChatCopyWith<_Chat> get copyWith;
}
