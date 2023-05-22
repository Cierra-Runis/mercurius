// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_latest_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubLatestRelease _$GithubLatestReleaseFromJson(Map<String, dynamic> json) =>
    GithubLatestRelease()
      ..tag_name = json['tag_name'] as String?
      ..name = json['name'] as String?
      ..draft = json['draft'] as bool?
      ..prerelease = json['prerelease'] as bool?
      ..assets = (json['assets'] as List<dynamic>?)
          ?.map((e) =>
              GithubLatestReleaseAsset.fromJson(e as Map<String, dynamic>))
          .toList()
      ..body = json['body'] as String?;

Map<String, dynamic> _$GithubLatestReleaseToJson(
        GithubLatestRelease instance) =>
    <String, dynamic>{
      'tag_name': instance.tag_name,
      'name': instance.name,
      'draft': instance.draft,
      'prerelease': instance.prerelease,
      'assets': instance.assets,
      'body': instance.body,
    };

GithubLatestReleaseAsset _$GithubLatestReleaseAssetFromJson(
        Map<String, dynamic> json) =>
    GithubLatestReleaseAsset()
      ..name = json['name'] as String?
      ..size = json['size'] as int?
      ..download_count = json['download_count'] as int?
      ..created_at = json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String)
      ..updated_at = json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String)
      ..browser_download_url = json['browser_download_url'] as String?;

Map<String, dynamic> _$GithubLatestReleaseAssetToJson(
        GithubLatestReleaseAsset instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
      'download_count': instance.download_count,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'browser_download_url': instance.browser_download_url,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$githubLatestReleaseHash() =>
    r'cd2be2f1ee55c6599c4b63ee69615072bdc17953';

/// See also [githubLatestRelease].
@ProviderFor(githubLatestRelease)
final githubLatestReleaseProvider =
    AutoDisposeFutureProvider<GithubLatestRelease>.internal(
  githubLatestRelease,
  name: r'githubLatestReleaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$githubLatestReleaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GithubLatestReleaseRef
    = AutoDisposeFutureProviderRef<GithubLatestRelease>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
