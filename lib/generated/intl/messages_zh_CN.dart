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

  static String m1(count) => "${count} 字";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("关于"),
        "back": MessageLookupByLibrary.simpleMessage("返回"),
        "changeDate": MessageLookupByLibrary.simpleMessage("修改日期"),
        "changeMood": MessageLookupByLibrary.simpleMessage("修改心情"),
        "changeWeather": MessageLookupByLibrary.simpleMessage("修改天气"),
        "contentCannotBeEmpty": MessageLookupByLibrary.simpleMessage("内容不能为空"),
        "createNewDiary": MessageLookupByLibrary.simpleMessage("创建新日记"),
        "diaryCount": m0,
        "homePage": MessageLookupByLibrary.simpleMessage("主页"),
        "imageGallery": MessageLookupByLibrary.simpleMessage("图片库"),
        "importAndExport": MessageLookupByLibrary.simpleMessage("导入导出"),
        "insertImage": MessageLookupByLibrary.simpleMessage("插入图片"),
        "insertTime": MessageLookupByLibrary.simpleMessage("插入时间"),
        "monthlyWordCountStatistics":
            MessageLookupByLibrary.simpleMessage("月度字数统计"),
        "morePage": MessageLookupByLibrary.simpleMessage("更多"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "settings": MessageLookupByLibrary.simpleMessage("设定"),
        "statistics": MessageLookupByLibrary.simpleMessage("统计数据"),
        "untitled": MessageLookupByLibrary.simpleMessage("无标题"),
        "wordCount": m1,
        "writingSomethingHere": MessageLookupByLibrary.simpleMessage("写些什么吧……")
      };
}
