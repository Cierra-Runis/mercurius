// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(count) => "共 ${count} 篇";

  static String m1(mood) => "${Intl.select(mood, {
            'other': 'Unknown Mood',
            'smile': '开心',
            'angry': '生气',
            'confused': '困惑',
            'frown': '难过',
            'laughing': '大笑',
            'silentSquint': '难受',
            'sadCrying': '大哭',
            'smileDizzy': '我死',
            'normal': '一般',
          })}";

  static String m2(weather) => "${Intl.select(weather, {
            'other': '未知',
            'sunny': '晴',
            'cloudy': '多云',
            'fewClouds': '少云',
            'heavyThunderstorm': '雷暴',
            'lightRain': '小雨',
            'heavyRain': '大雨',
            'lightSnow': '小雪',
            'heavySnow': '大雪',
            'foggy': '雾',
          })}";

  static String m3(count) => "${count} 字";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("关于"),
        "alreadyTheLatestVersion":
            MessageLookupByLibrary.simpleMessage("已是最新版本"),
        "alwaysBright": MessageLookupByLibrary.simpleMessage("常亮模式"),
        "alwaysDark": MessageLookupByLibrary.simpleMessage("常暗模式"),
        "areYouSureToDeleteTheDiary":
            MessageLookupByLibrary.simpleMessage("确定删除日记吗？"),
        "areYouSureToDeleteTheImage":
            MessageLookupByLibrary.simpleMessage("确定删除图片吗？"),
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "backAgainToExit": MessageLookupByLibrary.simpleMessage("再次返回以退出"),
        "buttonVibration": MessageLookupByLibrary.simpleMessage("按钮振动"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "changeDate": MessageLookupByLibrary.simpleMessage("修改日期"),
        "changeMood": MessageLookupByLibrary.simpleMessage("修改心情"),
        "changeWeather": MessageLookupByLibrary.simpleMessage("修改天气"),
        "clickHereToUpgrade": MessageLookupByLibrary.simpleMessage("点此更新版本"),
        "confirm": MessageLookupByLibrary.simpleMessage("确认"),
        "contactUs": MessageLookupByLibrary.simpleMessage("联系我们"),
        "content": MessageLookupByLibrary.simpleMessage("内容"),
        "contentCannotBeEmpty": MessageLookupByLibrary.simpleMessage("内容不能为空"),
        "createNewDiary": MessageLookupByLibrary.simpleMessage("创建新日记"),
        "darkMode": MessageLookupByLibrary.simpleMessage("深色模式"),
        "diaryCount": m0,
        "disabled": MessageLookupByLibrary.simpleMessage("已禁用"),
        "enabled": MessageLookupByLibrary.simpleMessage("已启用"),
        "export": MessageLookupByLibrary.simpleMessage("导出"),
        "exportJsonFile": MessageLookupByLibrary.simpleMessage("导出 json 文件"),
        "exportNfcData": MessageLookupByLibrary.simpleMessage("导出 NFC 数据"),
        "failedToGetVersion": MessageLookupByLibrary.simpleMessage("获取版本失败"),
        "followTheSystem": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "hiToKoToFetching": MessageLookupByLibrary.simpleMessage("正在获取「一言」"),
        "hiToKoToProvider":
            MessageLookupByLibrary.simpleMessage("该服务由 Hitokoto「一言」 提供"),
        "homePage": MessageLookupByLibrary.simpleMessage("主页"),
        "howIsYourMoodNow": MessageLookupByLibrary.simpleMessage("现在心情如何？"),
        "howIsYourMoodNowDescription":
            MessageLookupByLibrary.simpleMessage("ねぇ、今どんな気持ち"),
        "imageGallery": MessageLookupByLibrary.simpleMessage("图片库"),
        "imageMissing": MessageLookupByLibrary.simpleMessage("图片缺失"),
        "import": MessageLookupByLibrary.simpleMessage("导入"),
        "importAndExport": MessageLookupByLibrary.simpleMessage("导入导出"),
        "importDeclaration": MessageLookupByLibrary.simpleMessage("引用说明"),
        "importDeclarationContent": MessageLookupByLibrary.simpleMessage(
            "欢迎使用 Cierra_Runis 提供的 Mercurius 软件及服务。\n\n本次 Cierra_Runis 编写了《Mercurius 引入声明》（以下简称「本声明」）。\n\n一、字体声明\n1. Mercurius 引入了 Saira 字体作为 Mercurius 的主要字体。[License](https://github.com/Omnibus-Type/Saira/blob/master/OFL.txt)\n\n二、图标声明\n1. Mercurius 引入了 Material Icons 作为 Mercurius 的主要图标。[License](https://github.com/qwd/Icons/blob/main/LICENSE)\n2. Mercurius 引入了 unicons 作为 Mercurius 的次要图标。[License](https://github.com/pedrolemoz/unicons-flutter/blob/master/LICENSE)\n\n三、天气服务声明\n1. Mercurius 引入了 [和风天气](https://www.qweather.com) 驱动 Mercurius 的天气服务。"),
        "importDeclarationContentUpdateTime":
            MessageLookupByLibrary.simpleMessage("更新于 2023 年 6 月 4 日"),
        "importDeclarationDescription":
            MessageLookupByLibrary.simpleMessage("字体、图标、天气服务相关"),
        "importJsonFile": MessageLookupByLibrary.simpleMessage("导入 json 文件"),
        "importNfcData": MessageLookupByLibrary.simpleMessage("导入 NFC 数据"),
        "insertImage": MessageLookupByLibrary.simpleMessage("插入图片"),
        "insertTheImageFrom": MessageLookupByLibrary.simpleMessage("从何处插入图片？"),
        "insertTime": MessageLookupByLibrary.simpleMessage("插入时间"),
        "monthlyWordCountStatistics":
            MessageLookupByLibrary.simpleMessage("月度字数统计"),
        "mood": MessageLookupByLibrary.simpleMessage("心情"),
        "moodText": m1,
        "morePage": MessageLookupByLibrary.simpleMessage("更多"),
        "noData": MessageLookupByLibrary.simpleMessage("无数据"),
        "notYetCompleted": MessageLookupByLibrary.simpleMessage("暂未完成"),
        "pleaseBackToHomePage": MessageLookupByLibrary.simpleMessage("请回到主页"),
        "pleaseThinkTwiceAboutDeletingTheDiary":
            MessageLookupByLibrary.simpleMessage("请再三思考是否删除日记"),
        "pleaseThinkTwiceAboutDeletingTheImage":
            MessageLookupByLibrary.simpleMessage("再三思考是否删除图片"),
        "privacyStatement": MessageLookupByLibrary.simpleMessage("隐私政策"),
        "privacyStatementContent": MessageLookupByLibrary.simpleMessage(
            "欢迎使用 Cierra_Runis 提供的 Mercurius 软件及服务。\n\n为了更好的保护您的个人信息，请您仔细阅读本政策。\n\n如您对本政策有任何异议或疑问，您可通过本政策第五条中公布的联系方式与 Cierra_Runis 沟通。\n\n一、引言\n1. 本政策适用于 Mercurius 安卓端应用程序。\n2. 请您在使用 Mercurius 的服务前仔细阅读并充分理解本政策的全部内容。一旦您继续使用 Mercurius 软件及服务，即表示您已经同意 Cierra_Runis 按照本政策使用和处理您的相关信息。\n3. Cierra_Runis 会根据相关的法律法规不定时更新本政策，本政策在更新变动后，请确认本政策的新增内容。\n4. 请您同意并且理解只有您确认变更后的本政策，Cierra_Runis 才会依据更新变动后的本政策来收集、使用、储存、处理您的个人信息；您有权拒绝更新变更后的本政策。但请您知悉，一旦拒绝同意变更后的本政策将会导致您不能继续完整使用 Mercurius 相关服务和功能。\n\n二、关于 Cierra_Runis\n1. Mercurius 由 Cierra_Runis 个人提供软件服务。\n2. Cierra_Runis 的基本信息如下：个人网站为 [https://github.com/Cierra-Runis](https://github.com/Cierra-Runis) 。\n\n三、Mercurius 的信息策略\n1. Mercurius 产生的所有数据均在本地进行储存，不会上传任何由 Mercurius 产生的数据，这包括你的日记和图片。\n\n四、适用范围\n1. Cierra_Runis 所有的服务都适用于本政策。若本政策与特定服务的隐私指引或声明有不一致之处，请以本政策为准。\n\n五、联系 Cierra_Runis\n1. 如您对本政策的内容或使用 Cierra_Runis 的服务时遇到的与隐私保护相关的事宜有任何疑问或进行咨询或投诉时，您均可以通过如下任一方式与 Cierra_Runis 取得联系：\n- 您可在 Mercurius 关于界面联系我们\n- 您可以写邮件至 [byrdsaron@gmail.com](byrdsaron@gmail.com)"),
        "privacyStatementContentUpdateTime":
            MessageLookupByLibrary.simpleMessage("更新于 2023 年 6 月 4 日"),
        "releasePage": MessageLookupByLibrary.simpleMessage("更新页"),
        "releasePageOops": MessageLookupByLibrary.simpleMessage("我超！请刷新页面！"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "searchDiaryContent": MessageLookupByLibrary.simpleMessage("查找日记内容"),
        "settings": MessageLookupByLibrary.simpleMessage("设定"),
        "statistics": MessageLookupByLibrary.simpleMessage("统计数据"),
        "systemFile": MessageLookupByLibrary.simpleMessage("系统文件"),
        "title": MessageLookupByLibrary.simpleMessage("标题"),
        "unknownVersion": MessageLookupByLibrary.simpleMessage("未知版本"),
        "unsupportedImageFormat":
            MessageLookupByLibrary.simpleMessage("不支持的图片格式"),
        "untitled": MessageLookupByLibrary.simpleMessage("无标题"),
        "weather": MessageLookupByLibrary.simpleMessage("天气"),
        "weatherText": m2,
        "whatIsTheWeatherNow": MessageLookupByLibrary.simpleMessage("现在天气如何？"),
        "whatIsTheWeatherNowDescription":
            MessageLookupByLibrary.simpleMessage("今日もいい天気"),
        "wordCount": m3,
        "writingSomethingHere": MessageLookupByLibrary.simpleMessage("写些什么吧……")
      };
}
