// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, one: '${count} diary', other: '${count} diaries')}";

  static String m1(count) =>
      "${Intl.plural(count, one: '${count} word', other: '${count} words')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutUs": MessageLookupByLibrary.simpleMessage("About Us"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "changeDate": MessageLookupByLibrary.simpleMessage("Change Date"),
        "changeMood": MessageLookupByLibrary.simpleMessage("Change Mood"),
        "changeWeather": MessageLookupByLibrary.simpleMessage("Change Weather"),
        "contentCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Content cannot be empty"),
        "createNewDiary":
            MessageLookupByLibrary.simpleMessage("Create New Diary"),
        "diaryCount": m0,
        "homePage": MessageLookupByLibrary.simpleMessage("Home"),
        "imageGallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "importAndExport":
            MessageLookupByLibrary.simpleMessage("Import & Export"),
        "insertImage": MessageLookupByLibrary.simpleMessage("Insert Image"),
        "insertTime": MessageLookupByLibrary.simpleMessage("Insert Time"),
        "monthlyWordCountStatistics": MessageLookupByLibrary.simpleMessage(
            "Monthly word count statistics"),
        "morePage": MessageLookupByLibrary.simpleMessage("More"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
        "untitled": MessageLookupByLibrary.simpleMessage("Untitled"),
        "wordCount": m1,
        "writingSomethingHere":
            MessageLookupByLibrary.simpleMessage("Writing Something Here...")
      };
}
