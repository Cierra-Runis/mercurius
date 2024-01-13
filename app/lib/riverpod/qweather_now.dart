import '../../app/lib/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'qweather_now.g.dart';
part 'qweather_now.freezed.dart';

@riverpod
Future<QWeatherNow> qWeatherNow(
  QWeatherNowRef ref,
) async {
  ref.keepAlive();
  final currentPosition = await ref.watch(currentPositionProvider.future);

  final apiUrl = MercuriusApi.qWeather.apiUrl;
  final aqiKey = MercuriusApi.qWeather.apiKey;

  var qWeather = const _QWeather();
  const qWeatherNow = QWeatherNow();

  Response response;
  try {
    response = await Dio().get(
      apiUrl,
      queryParameters: {
        'key': aqiKey,
        'location': '${currentPosition.latitude},${currentPosition.longitude}',
      },
    );
  } catch (e) {
    return qWeatherNow;
  }

  if (response.statusCode == 200) {
    qWeather = _QWeather.fromJson(
      jsonDecode('$response'),
    );
  }
  return qWeather.now ?? qWeatherNow;
}

@freezed
class QWeatherNow with _$QWeatherNow {
  const factory QWeatherNow({
    @JsonKey(name: 'icon') String? icon,
  }) = _QWeatherNow;

  const QWeatherNow._();

  factory QWeatherNow.fromJson(Map<String, Object?> json) =>
      _$QWeatherNowFromJson(json);
}

@freezed
class _QWeather with _$QWeather {
  const factory _QWeather({
    @JsonKey(name: 'now') QWeatherNow? now,
  }) = __QWeather;

  factory _QWeather.fromJson(Map<String, Object?> json) =>
      _$QWeatherFromJson(json);
}
