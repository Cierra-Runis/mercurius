// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_search_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiarySearch _$DiarySearchFromJson(Map<String, dynamic> json) => DiarySearch(
      text: json['text'] as String,
    );

Map<String, dynamic> _$DiarySearchToJson(DiarySearch instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$diarySearchTextHash() => r'b2e5221700bda35c519b9ac82f0555e308c0fa04';

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
