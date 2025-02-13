import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_position.freezed.dart';
part 'current_position.g.dart';

@riverpod
Future<CurrentPosition> currentPosition(Ref ref) async {
  ref.refreshFor(const Duration(minutes: 10));
  final Response response;

  try {
    response = await App.dio.get(
      App.aMapApiUrl,
      queryParameters: {
        'key': App.aMapApiKey,
        'output': 'json',
      },
    );
  } catch (e) {
    return const CurrentPosition();
  }

  if (response.statusCode != 200 || response.data is! Map) {
    return const CurrentPosition();
  }

  final data = response.data as Map;
  if (data['province'] == null ||
      data['city'] == null ||
      data['rectangle'] == null) {
    return const CurrentPosition();
  }

  final match = RegExp(r'(.*),(.*);').firstMatch(data['rectangle']);

  if (match == null) return const CurrentPosition();

  return CurrentPosition(
    latitude: double.parse('${match[1]}').toStringAsFixed(2),
    longitude: double.parse('${match[2]}').toStringAsFixed(2),
    city: data['city'],
  );
}

@freezed
class CurrentPosition with _$CurrentPosition {
  const factory CurrentPosition({
    @JsonKey(name: 'latitude') @Default('116.38') String latitude,
    @JsonKey(name: 'longitude') @Default('39.91') String longitude,
    @JsonKey(name: 'city') @Default('北京市') String city,
  }) = _CurrentPosition;

  String get humanFormat => '${latitude}N ${longitude}E';

  const CurrentPosition._();

  factory CurrentPosition.fromJson(Json json) =>
      _$CurrentPositionFromJson(json);
}
