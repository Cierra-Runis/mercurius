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

String _$currentPositionHash() => r'048b99fb4599f1060ed293abfa0cef545e1a0fd3';

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
