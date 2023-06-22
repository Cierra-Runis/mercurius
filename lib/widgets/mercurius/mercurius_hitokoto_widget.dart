import 'package:mercurius/index.dart';

const String _url = 'https://v1.hitokoto.cn/';

const String _connectErrorJsonString =
    '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！[连接失败]","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}';

const String _responseErrorJsonString =
    '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！[请求失败]","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}';

class MercuriusHiToKoToWidget extends StatelessWidget {
  const MercuriusHiToKoToWidget({super.key});

  /// FIXME: 当组件被挡住时仍然进行刷新
  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return StreamBuilder<Future<HiToKoTo>>(
      stream:
          Stream.periodic(const Duration(seconds: 3), (_) => _fetchHiToKoTo()),
      builder: (context, snapshot) {
        return FutureBuilder<HiToKoTo>(
          future: snapshot.data,
          builder: (context, snapshot) {
            return InkWell(
              onTap: () => launchUrlString(
                'https://hitokoto.cn/?uuid=${snapshot.data!.uuid!}',
                mode: LaunchMode.externalApplication,
              ),
              child: Tooltip(
                message: l10n.hiToKoToProvider,
                preferBelow: false,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: Text(
                    snapshot.hasData
                        ? snapshot.data!.hitokoto
                        : l10n.hiToKoToFetching,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    key: Key(
                      snapshot.data?.hitokoto ?? l10n.hiToKoToFetching,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<HiToKoTo> _fetchHiToKoTo() async {
    Response response;

    try {
      response = await Dio().get(_url);
    } catch (e) {
      return HiToKoTo.fromJson(
        jsonDecode(_connectErrorJsonString),
      );
    }

    if (response.statusCode == 200) {
      return HiToKoTo.fromJson(
        jsonDecode('$response'),
      );
    } else {
      return HiToKoTo.fromJson(
        jsonDecode(_responseErrorJsonString),
      );
    }
  }
}
