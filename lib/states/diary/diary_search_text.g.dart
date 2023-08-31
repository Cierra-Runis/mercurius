// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_search_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiarySearch _$DiarySearchFromJson(Map<String, dynamic> json) => DiarySearch(
      text: json['text'] as String? ?? '\\n',
      searchTitle: json['searchTitle'] as bool? ?? false,
    );

Map<String, dynamic> _$DiarySearchToJson(DiarySearch instance) =>
    <String, dynamic>{
      'text': instance.text,
      'searchTitle': instance.searchTitle,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$diarySearchTextHash() => r'a8cd631aa1362c7115ca2bc829dd2c2d31f2b394';

/// See also [DiarySearchText].
@ProviderFor(DiarySearchText)
final diarySearchTextProvider =
    AutoDisposeNotifierProvider<DiarySearchText, DiarySearch>.internal(
  DiarySearchText.new,
  name: r'diarySearchTextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$diarySearchTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DiarySearchText = AutoDisposeNotifier<DiarySearch>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
