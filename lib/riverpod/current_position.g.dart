// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentPosition _$CurrentPositionFromJson(Map<String, dynamic> json) =>
    CurrentPosition()
      ..latitude = json['latitude'] as String
      ..longitude = json['longitude'] as String
      ..city = json['city'] as String
      ..dateTime = DateTime.parse(json['dateTime'] as String);

Map<String, dynamic> _$CurrentPositionToJson(CurrentPosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'dateTime': instance.dateTime.toIso8601String(),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentPositionHash() => r'f64a91ad33c3fc56a9f6f816986af8439cd474cf';

/// 使用高德 api 获取位置
///
/// Copied from [currentPosition].
@ProviderFor(currentPosition)
final currentPositionProvider =
    AutoDisposeFutureProvider<CurrentPosition>.internal(
  currentPosition,
  name: r'currentPositionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPositionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentPositionRef = AutoDisposeFutureProviderRef<CurrentPosition>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
