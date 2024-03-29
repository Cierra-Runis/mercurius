import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_position.g.dart';
part 'current_position.freezed.dart';

@riverpod
Future<CurrentPosition> currentPosition(CurrentPositionRef ref) async {
  ref.keepAlive();
  Response response;
  var newCachePosition = const CurrentPosition();

  try {
    response = await Dio().get(
      MercuriusApi.aMap.apiUrl,
      queryParameters: {
        'key': MercuriusApi.aMap.apiKey,
        'output': 'json',
      },
    );
  } catch (e) {
    return newCachePosition;
  }

  dynamic data;
  if (response.statusCode == 200) {
    data = jsonDecode('$response');
    if (data['province'] == null ||
        data['city'] == null ||
        data['rectangle'] == null) {
      return newCachePosition;
    }
  } else {
    return newCachePosition;
  }

  final match = RegExp(r'(.*),(.*);').firstMatch(data['rectangle']);

  newCachePosition = CurrentPosition(
    latitude: double.parse('${match![1]}').toStringAsFixed(2),
    longitude: double.parse('${match[2]}').toStringAsFixed(2),
    city: data['city'],
  );

  return newCachePosition;
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

  factory CurrentPosition.fromJson(Map<String, Object?> json) =>
      _$CurrentPositionFromJson(json);
}
