import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qweather_now.freezed.dart';
part 'qweather_now.g.dart';

@riverpod
Future<QWeatherNow> qWeatherNow(Ref ref) async {
  ref.refreshFor(const Duration(minutes: 10));
  final currentPosition = await ref.watch(currentPositionProvider.future);

  Response response;
  try {
    response = await App.dio.get(
      App.qWeatherApiUrl,
      queryParameters: {
        'key': App.qWeatherApiKey,
        'location': '${currentPosition.latitude},${currentPosition.longitude}',
      },
    );
  } catch (e) {
    return const QWeatherNow();
  }

  if (response.statusCode == 200) {
    return _QWeather.fromJson(jsonDecode('$response')).now ??
        const QWeatherNow();
  }
  return const _QWeather().now ?? const QWeatherNow();
}

@freezed
class QWeatherNow with _$QWeatherNow {
  const factory QWeatherNow({
    @JsonKey(name: 'icon') String? icon,
  }) = _QWeatherNow;

  const QWeatherNow._();

  factory QWeatherNow.fromJson(Json json) => _$QWeatherNowFromJson(json);
}

@freezed
class _QWeather with _$QWeather {
  const factory _QWeather({
    @JsonKey(name: 'now') QWeatherNow? now,
  }) = __QWeather;

  factory _QWeather.fromJson(Json json) => _$QWeatherFromJson(json);
}
