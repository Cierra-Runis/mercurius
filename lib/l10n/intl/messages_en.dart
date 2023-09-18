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
      "${Intl.plural(count, one: '${count} Diary', other: '${count} Diaries')}";

  static String m1(mood) => "${Intl.select(mood, {
            'other': 'Unknown Mood',
            'smile': 'Happy',
            'angry': 'Angry',
            'confused': 'Confused',
            'frown': 'Frown',
            'laughing': 'Laughing',
            'silentSquint': 'Silent Squint',
            'sadCrying': 'Sad Crying',
            'smileDizzy': 'Smile Dizzy',
            'normal': 'Normal',
          })}";

  static String m2(weather) => "${Intl.select(weather, {
            'other': 'Unknown Weather',
            'sunny': 'Sunny',
            'cloudy': 'Cloudy',
            'fewClouds': 'Few Clouds',
            'heavyThunderstorm': 'Heavy Thunderstorm',
            'lightRain': 'Light Rain',
            'heavyRain': 'Heavy Rain',
            'lightSnow': 'Light Snow',
            'heavySnow': 'Heavy Snow',
            'foggy': 'Foggy',
          })}";

  static String m3(count) =>
      "${Intl.plural(count, one: '${count} Word', other: '${count} Words')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("About App"),
        "alreadyTheLatestVersion":
            MessageLookupByLibrary.simpleMessage("Updated"),
        "alwaysBright": MessageLookupByLibrary.simpleMessage("Always Bright"),
        "alwaysDark": MessageLookupByLibrary.simpleMessage("Always Dark"),
        "areYouSureToDeleteTheDiary":
            MessageLookupByLibrary.simpleMessage("Confirm delete the diary?"),
        "areYouSureToDeleteTheImage":
            MessageLookupByLibrary.simpleMessage("Confirm delete the image?"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "backAgainToExit":
            MessageLookupByLibrary.simpleMessage("Go Back Again To Exit"),
        "buttonVibration":
            MessageLookupByLibrary.simpleMessage("Button vibration"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeDate": MessageLookupByLibrary.simpleMessage("Change Date"),
        "changeMood": MessageLookupByLibrary.simpleMessage("Change Mood"),
        "changeWeather": MessageLookupByLibrary.simpleMessage("Change Weather"),
        "clickHereToUpdate": MessageLookupByLibrary.simpleMessage("To Update"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
        "content": MessageLookupByLibrary.simpleMessage("Content"),
        "contentCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Content Cannot Be Empty"),
        "continueEditingDiary":
            MessageLookupByLibrary.simpleMessage("Continue Editing Diary"),
        "createNewDiary":
            MessageLookupByLibrary.simpleMessage("Create New Diary"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "diaryCount": m0,
        "disabled": MessageLookupByLibrary.simpleMessage("Disabled"),
        "enabled": MessageLookupByLibrary.simpleMessage("Enabled"),
        "export": MessageLookupByLibrary.simpleMessage("Export"),
        "exportJsonFile":
            MessageLookupByLibrary.simpleMessage("Export JSON File"),
        "exportNfcData":
            MessageLookupByLibrary.simpleMessage("Export NFC Data"),
        "failedToGetVersion":
            MessageLookupByLibrary.simpleMessage("Failed To Get Version"),
        "followTheSystem":
            MessageLookupByLibrary.simpleMessage("Follow The System"),
        "hiToKoToFetching":
            MessageLookupByLibrary.simpleMessage("Fetching 「一言」..."),
        "hiToKoToProvider": MessageLookupByLibrary.simpleMessage(
            "This service is provided by Hitokoto「一言」"),
        "homePage": MessageLookupByLibrary.simpleMessage("Home"),
        "howIsYourMoodNow":
            MessageLookupByLibrary.simpleMessage("How is your mood now?"),
        "howIsYourMoodNowDescription":
            MessageLookupByLibrary.simpleMessage("ねぇ、今どんな気持ち"),
        "imageGallery": MessageLookupByLibrary.simpleMessage("Gallery"),
        "imageMissing": MessageLookupByLibrary.simpleMessage("Image Missing"),
        "import": MessageLookupByLibrary.simpleMessage("Import"),
        "importAndExport":
            MessageLookupByLibrary.simpleMessage("Import & Export"),
        "importDeclaration":
            MessageLookupByLibrary.simpleMessage("Import Declaration"),
        "importDeclarationContent": MessageLookupByLibrary.simpleMessage(
            "Welcome to Mercurius software and services from Cierra_Runis. \n\nThis time, Cierra_Runis has prepared the \"Mercurius Introduction Declaration\" (hereinafter referred to as \"the declaration\"). \n\nI. Font Declaration\n1. Mercurius introduced Saira font as the main font of Mercurius. [License](https://github.com/Omnibus-Type/Saira/blob/master/OFL.txt)\n\nII. Icon Declaration\n1. Mercurius introduced Material Icons as the main icon of Mercurius. [License](https://github.com/qwd/Icons/blob/main/LICENSE)\n2. Mercurius introduced unicons as secondary icons for Mercurius. [License](https://github.com/pedrolemoz/unicons-flutter/blob/master/LICENSE)\n\nIII. Weather Service Declaration\n1. Mercurius introduced [QWeather](https://www.qweather.com) drives Mercurius\' weather service."),
        "importDeclarationContentUpdateTime":
            MessageLookupByLibrary.simpleMessage("Updated on June 04, 2023"),
        "importDeclarationDescription": MessageLookupByLibrary.simpleMessage(
            "Fonts, Icons, Weather Service Related"),
        "importJsonFile":
            MessageLookupByLibrary.simpleMessage("Import JSON File"),
        "importNfcData":
            MessageLookupByLibrary.simpleMessage("Import NFC Data"),
        "insertImage": MessageLookupByLibrary.simpleMessage("Insert Image"),
        "insertTag": MessageLookupByLibrary.simpleMessage("Insert Tag"),
        "insertTagMessage":
            MessageLookupByLibrary.simpleMessage("Please Enter Tag Message"),
        "insertTagTitle": MessageLookupByLibrary.simpleMessage(
            "Please Select The Tag Icon And Enter Message"),
        "insertTheImageFrom":
            MessageLookupByLibrary.simpleMessage("Insert the image from..."),
        "monthlyWordCountStatistics":
            MessageLookupByLibrary.simpleMessage("Monthly Word Count"),
        "mood": MessageLookupByLibrary.simpleMessage("Mood"),
        "moodText": m1,
        "morePage": MessageLookupByLibrary.simpleMessage("More"),
        "noData": MessageLookupByLibrary.simpleMessage("No Data"),
        "notYetCompleted":
            MessageLookupByLibrary.simpleMessage("Not Yet Completed"),
        "pleaseBackToHomePage":
            MessageLookupByLibrary.simpleMessage("Please Back To Home Page"),
        "pleaseThinkTwiceAboutDeletingTheDiary":
            MessageLookupByLibrary.simpleMessage(
                "Please think twice about deleting the diary"),
        "pleaseThinkTwiceAboutDeletingTheImage":
            MessageLookupByLibrary.simpleMessage(
                "Please think twice about deleting the image"),
        "privacyStatement":
            MessageLookupByLibrary.simpleMessage("Privacy Statement"),
        "privacyStatementContent": MessageLookupByLibrary.simpleMessage(
            "Welcome to Mercurius software and services from Cierra_Runis.\n\nIn order to better protect your personal information, please read this policy carefully.\n\nIf you have any objections or questions about this policy, you can communicate with Cierra_Runis through the contact information published in Article 5 of this policy.\n\nI. Introduction\n1. This policy applies to Mercurius multi-platform applications.\n2. Please read carefully and fully understand the entire content of this policy before using Mercurius\' services. Once you continue to use Mercurius software and services, you have agreed to Cierra_Runis using and processing your relevant information in accordance with this policy.\n3. Cierra_Runis will update this policy from time to time in accordance with relevant laws and regulations. After this policy is updated and changed, please confirm the new content of this policy.\n4. Please agree and understand that only after you confirm the changed policy, Cierra_Runis will collect, use, store, and process your personal information in accordance with the updated policy; you have the right to refuse to update the changed policy . But please be aware that once you refuse to agree to the changed policy, you will not be able to continue to use Mercurius related services and functions in full.\n\nII. About Cierra_Runis\n1. Mercurius is provided by Cierra_Runis personally.\n2. The basic information of Cierra_Runis is as follows: Personal website is [https://github.com/Cierra-Runis](https://github.com/Cierra-Runis).\n\nIII. Mercurius\' information policy\n1. All data generated by Mercurius are stored locally, and any data generated by Mercurius will not be uploaded, including your diary and images.\n\nIV. scope of application\n1. All services of Cierra_Runis are applicable to this policy. If there is any inconsistency between this policy and the privacy guidelines or statements of specific services, this policy shall prevail.\n\nV. Contact Cierra_Runis\n1. If you have any questions about the content of this policy or the privacy protection-related matters you encounter when using Cierra_Runis\' services, or make inquiries or complaints, you can use any of the following methods Get in touch with Cierra_Runis:\n- You can reach us in the Mercurius About page\n- You can write to [byrdsaron@gmail.com](byrdsaron@gmail.com)"),
        "privacyStatementContentUpdateTime":
            MessageLookupByLibrary.simpleMessage("Updated on July 12, 2023"),
        "releasePage": MessageLookupByLibrary.simpleMessage("Release Page"),
        "releasePageOops": MessageLookupByLibrary.simpleMessage(
            "Oops! Please refresh the page!"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchDiary": MessageLookupByLibrary.simpleMessage("Search Diary"),
        "searchTitle": MessageLookupByLibrary.simpleMessage("Search Title"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
        "systemFile": MessageLookupByLibrary.simpleMessage("System File"),
        "thisDayLastYear":
            MessageLookupByLibrary.simpleMessage("This Day Last Year"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "unknownVersion":
            MessageLookupByLibrary.simpleMessage("Unknown Version"),
        "unsupportedImageFormat":
            MessageLookupByLibrary.simpleMessage("Unsupported Image Format"),
        "untitled": MessageLookupByLibrary.simpleMessage("Untitled"),
        "weather": MessageLookupByLibrary.simpleMessage("Weather"),
        "weatherText": m2,
        "whatIsTheWeatherNow":
            MessageLookupByLibrary.simpleMessage("What is the weather now?"),
        "whatIsTheWeatherNowDescription":
            MessageLookupByLibrary.simpleMessage("今日もいい天気"),
        "wordCount": m3,
        "writingSomethingHere":
            MessageLookupByLibrary.simpleMessage("Writing Something Here...")
      };
}
