import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hitokoto.g.dart';

const String _url = 'https://v1.hitokoto.cn/';

@riverpod
Future<HiToKoTo> hitokoto(HitokotoRef ref) async {
  ref.refreshFor(const Duration(seconds: 5));
  Response response;

  try {
    response = await App.dio.get(_url);
  } catch (e) {
    return const HiToKoTo(
      hitokoto: '没有BUG的代码是不完美的！[连接失败]',
      uuid: 'd4ea5c57-bd64-4b9c-81a1-3035bc059b43',
    );
  }

  if (response.statusCode != 200 || response.data is! Map) {
    return const HiToKoTo(
      hitokoto: '没有BUG的代码是不完美的！[请求失败]',
      uuid: 'd4ea5c57-bd64-4b9c-81a1-3035bc059b43',
    );
  }

  return HiToKoTo.fromJson(
    response.data,
  );
}
