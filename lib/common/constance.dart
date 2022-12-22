import 'package:mercurius/index.dart';

class Constance {
  static Map<int, String> weekdayMap = {
    1: '星期一',
    2: '星期二',
    3: '星期三',
    4: '星期四',
    5: '星期五',
    6: '星期六',
    7: '星期日',
  };

  static Map<String, IconData> moodMap = {
    '开心': UniconsLine.smile,
    '一般': UniconsLine.meh_closed_eye,
    '生气': UniconsLine.angry,
    '困惑': UniconsLine.confused,
    '失落': UniconsLine.frown,
    '大笑': UniconsLine.laughing,
    '难受': UniconsLine.silent_squint,
    '大哭': UniconsLine.sad_crying,
    '我死': UniconsLine.smile_dizzy,
  };

  /// 天气 `api` 所需开发者 `key`
  static String weatherKey = 'a13fc8e191d14cc0930bc07c6660d900';
}
