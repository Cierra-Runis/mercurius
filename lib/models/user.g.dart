// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..mercuriusId = json['mercuriusId'] as num?
  ..username = json['username'] as String?
  ..email = json['email'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'mercuriusId': instance.mercuriusId,
      'username': instance.username,
      'email': instance.email,
    };
