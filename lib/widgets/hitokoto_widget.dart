import 'package:mercurius/index.dart';

const String _url = 'https://v1.hitokoto.cn/';

class HiToKoToWidget extends StatefulWidget {
  const HiToKoToWidget({super.key});

  @override
  State<HiToKoToWidget> createState() => _HiToKoToWidgetState();
}

class _HiToKoToWidgetState extends State<HiToKoToWidget> {
  late Future<HiToKoTo> futureHiToKoTo;
  @override
  void initState() {
    super.initState();
    futureHiToKoTo = _fetchHiToKoTo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiToKoTo>(
      future: futureHiToKoTo,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!.hitokoto,
            style: TextStyle(
              fontSize: 12,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white54
                  : Colors.black54,
            ),
          );
        }
        return Text(
          '正在获取「一言」',
          style: TextStyle(
            fontSize: 12,
            color: (Theme.of(context).brightness == Brightness.dark)
                ? Colors.white54
                : Colors.black54,
          ),
        );
      }),
    );
  }
}

Future<HiToKoTo> _fetchHiToKoTo() async {
  Response response;
  try {
    response = await Dio().get(_url);
  } catch (e) {
    return HiToKoTo.fromJson(
      jsonDecode(
        '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！[无网络]","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}',
      ),
    );
  }

  if (response.statusCode == 200) {
    return HiToKoTo.fromJson(jsonDecode(response.toString()));
  } else {
    return HiToKoTo.fromJson(
      jsonDecode(
        '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！[请求失败]","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}',
      ),
    );
  }
}
