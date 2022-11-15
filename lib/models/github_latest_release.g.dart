// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_latest_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubLatestRelease _$GithubLatestReleaseFromJson(Map<String, dynamic> json) =>
    GithubLatestRelease()
      ..enable = json['enable'] as bool?
      ..maxAge = json['maxAge'] as num?
      ..maxCount = json['maxCount'] as num?;

Map<String, dynamic> _$GithubLatestReleaseToJson(
        GithubLatestRelease instance) =>
    <String, dynamic>{
      'enable': instance.enable,
      'maxAge': instance.maxAge,
      'maxCount': instance.maxCount,
    };
