// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(count) => "計 ${count} 本";

  static String m1(count) => "${count} 文字";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("アバウト"),
        "back": MessageLookupByLibrary.simpleMessage("戻る"),
        "changeDate": MessageLookupByLibrary.simpleMessage("日付を変える"),
        "changeMood": MessageLookupByLibrary.simpleMessage("気分を変える"),
        "changeWeather": MessageLookupByLibrary.simpleMessage("天気を変える"),
        "contentCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("コンテンツを空にすることはできません"),
        "createNewDiary": MessageLookupByLibrary.simpleMessage("日記を追加"),
        "diaryCount": m0,
        "homePage": MessageLookupByLibrary.simpleMessage("ホーム"),
        "imageGallery": MessageLookupByLibrary.simpleMessage("画廊"),
        "importAndExport": MessageLookupByLibrary.simpleMessage("データの輸出入"),
        "insertImage": MessageLookupByLibrary.simpleMessage("図を挿入"),
        "insertTime": MessageLookupByLibrary.simpleMessage("時間を挿入"),
        "monthlyWordCountStatistics":
            MessageLookupByLibrary.simpleMessage("月度文字数統計"),
        "morePage": MessageLookupByLibrary.simpleMessage("詳細"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "settings": MessageLookupByLibrary.simpleMessage("设定"),
        "statistics": MessageLookupByLibrary.simpleMessage("統計データ"),
        "untitled": MessageLookupByLibrary.simpleMessage("タイトル無し"),
        "wordCount": m1,
        "writingSomethingHere": MessageLookupByLibrary.simpleMessage("何かを書けよ…")
      };
}
