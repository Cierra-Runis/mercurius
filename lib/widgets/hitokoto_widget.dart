import 'package:mercurius/index.dart';

const String _url = 'https://v1.hitokoto.cn/';

const String _connectErrorJsonString =
    '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！[连接失败]","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}';

const String _responseErrorJsonString =
    '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！[请求失败]","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}';

class HiToKoToWidget extends StatefulWidget {
  const HiToKoToWidget({super.key});

  @override
  State<HiToKoToWidget> createState() => _HiToKoToWidgetState();
}

class _HiToKoToWidgetState extends State<HiToKoToWidget> {
  late Future<HiToKoTo> _futureHiToKoTo;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _futureHiToKoTo = _fetchHiToKoTo();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => setState(() {
        _futureHiToKoTo = _fetchHiToKoTo();
      }),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiToKoTo>(
      future: _futureHiToKoTo,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () => launchUrlString(
              'https://hitokoto.cn/?uuid=${snapshot.data!.uuid!}',
              mode: LaunchMode.externalApplication,
            ),
            child: Tooltip(
              message: '该服务由 Hitokoto「一言」 提供',
              preferBelow: false,
              child: Text(
                snapshot.data!.hitokoto,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          );
        }
        return Text(
          '正在获取「一言」',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.outline,
          ),
        );
      }),
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
        jsonDecode(response.toString()),
      );
    } else {
      return HiToKoTo.fromJson(
        jsonDecode(_responseErrorJsonString),
      );
    }
  }
}
