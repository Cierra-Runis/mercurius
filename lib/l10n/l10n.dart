// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class MercuriusL10N {
  MercuriusL10N();

  static MercuriusL10N? _current;

  static MercuriusL10N get current {
    assert(_current != null,
        'No instance of MercuriusL10N was loaded. Try to initialize the MercuriusL10N delegate before accessing MercuriusL10N.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<MercuriusL10N> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = MercuriusL10N();
      MercuriusL10N._current = instance;

      return instance;
    });
  }

  static MercuriusL10N of(BuildContext context) {
    final instance = MercuriusL10N.maybeOf(context);
    assert(instance != null,
        'No instance of MercuriusL10N present in the widget tree. Did you add MercuriusL10N.delegate in localizationsDelegates?');
    return instance!;
  }

  static MercuriusL10N? maybeOf(BuildContext context) {
    return Localizations.of<MercuriusL10N>(context, MercuriusL10N);
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Enabled`
  String get enabled {
    return Intl.message(
      'Enabled',
      name: 'enabled',
      desc: '',
      args: [],
    );
  }

  /// `Disabled`
  String get disabled {
    return Intl.message(
      'Disabled',
      name: 'disabled',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Untitled`
  String get untitled {
    return Intl.message(
      'Untitled',
      name: 'untitled',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get noData {
    return Intl.message(
      'No Data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Writing Something Here...`
  String get writingSomethingHere {
    return Intl.message(
      'Writing Something Here...',
      name: 'writingSomethingHere',
      desc: '',
      args: [],
    );
  }

  /// `Insert Image`
  String get insertImage {
    return Intl.message(
      'Insert Image',
      name: 'insertImage',
      desc: '',
      args: [],
    );
  }

  /// `Insert Tag`
  String get insertTag {
    return Intl.message(
      'Insert Tag',
      name: 'insertTag',
      desc: '',
      args: [],
    );
  }

  /// `Please Select The Tag Icon And Enter Message`
  String get insertTagTitle {
    return Intl.message(
      'Please Select The Tag Icon And Enter Message',
      name: 'insertTagTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Tag Message`
  String get insertTagMessage {
    return Intl.message(
      'Please Enter Tag Message',
      name: 'insertTagMessage',
      desc: '',
      args: [],
    );
  }

  /// `Change Mood`
  String get changeMood {
    return Intl.message(
      'Change Mood',
      name: 'changeMood',
      desc: '',
      args: [],
    );
  }

  /// `Change Weather`
  String get changeWeather {
    return Intl.message(
      'Change Weather',
      name: 'changeWeather',
      desc: '',
      args: [],
    );
  }

  /// `Change Date`
  String get changeDate {
    return Intl.message(
      'Change Date',
      name: 'changeDate',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get imageGallery {
    return Intl.message(
      'Gallery',
      name: 'imageGallery',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message(
      'Export',
      name: 'export',
      desc: '',
      args: [],
    );
  }

  /// `Import & Export`
  String get importAndExport {
    return Intl.message(
      'Import & Export',
      name: 'importAndExport',
      desc: '',
      args: [],
    );
  }

  /// `Import JSON File`
  String get importJsonFile {
    return Intl.message(
      'Import JSON File',
      name: 'importJsonFile',
      desc: '',
      args: [],
    );
  }

  /// `Import NFC Data`
  String get importNfcData {
    return Intl.message(
      'Import NFC Data',
      name: 'importNfcData',
      desc: '',
      args: [],
    );
  }

  /// `Export JSON File`
  String get exportJsonFile {
    return Intl.message(
      'Export JSON File',
      name: 'exportJsonFile',
      desc: '',
      args: [],
    );
  }

  /// `Export NFC Data`
  String get exportNfcData {
    return Intl.message(
      'Export NFC Data',
      name: 'exportNfcData',
      desc: '',
      args: [],
    );
  }

  /// `Please Back To Home Page`
  String get pleaseBackToHomePage {
    return Intl.message(
      'Please Back To Home Page',
      name: 'pleaseBackToHomePage',
      desc: '',
      args: [],
    );
  }

  /// `Not Yet Completed`
  String get notYetCompleted {
    return Intl.message(
      'Not Yet Completed',
      name: 'notYetCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Button vibration`
  String get buttonVibration {
    return Intl.message(
      'Button vibration',
      name: 'buttonVibration',
      desc: '',
      args: [],
    );
  }

  /// `Follow The System`
  String get followTheSystem {
    return Intl.message(
      'Follow The System',
      name: 'followTheSystem',
      desc: '',
      args: [],
    );
  }

  /// `Always Dark`
  String get alwaysDark {
    return Intl.message(
      'Always Dark',
      name: 'alwaysDark',
      desc: '',
      args: [],
    );
  }

  /// `Always Bright`
  String get alwaysBright {
    return Intl.message(
      'Always Bright',
      name: 'alwaysBright',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get aboutApp {
    return Intl.message(
      'About App',
      name: 'aboutApp',
      desc: '',
      args: [],
    );
  }

  /// `To Update`
  String get clickHereToUpdate {
    return Intl.message(
      'To Update',
      name: 'clickHereToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get alreadyTheLatestVersion {
    return Intl.message(
      'Updated',
      name: 'alreadyTheLatestVersion',
      desc: '',
      args: [],
    );
  }

  /// `Content Cannot Be Empty`
  String get contentCannotBeEmpty {
    return Intl.message(
      'Content Cannot Be Empty',
      name: 'contentCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message(
      'Home',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get morePage {
    return Intl.message(
      'More',
      name: 'morePage',
      desc: '',
      args: [],
    );
  }

  /// `Release Page`
  String get releasePage {
    return Intl.message(
      'Release Page',
      name: 'releasePage',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Please refresh the page!`
  String get releasePageOops {
    return Intl.message(
      'Oops! Please refresh the page!',
      name: 'releasePageOops',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Import Declaration`
  String get importDeclaration {
    return Intl.message(
      'Import Declaration',
      name: 'importDeclaration',
      desc: '',
      args: [],
    );
  }

  /// `Fonts, Icons, Weather Service Related`
  String get importDeclarationDescription {
    return Intl.message(
      'Fonts, Icons, Weather Service Related',
      name: 'importDeclarationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Updated on June 04, 2023`
  String get importDeclarationContentUpdateTime {
    return Intl.message(
      'Updated on June 04, 2023',
      name: 'importDeclarationContentUpdateTime',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Mercurius software and services from Cierra_Runis. \n\nThis time, Cierra_Runis has prepared the "Mercurius Introduction Declaration" (hereinafter referred to as "the declaration"). \n\nI. Font Declaration\n1. Mercurius introduced Saira font as the main font of Mercurius. [License](https://github.com/Omnibus-Type/Saira/blob/master/OFL.txt)\n\nII. Icon Declaration\n1. Mercurius introduced Material Icons as the main icon of Mercurius. [License](https://github.com/qwd/Icons/blob/main/LICENSE)\n2. Mercurius introduced unicons as secondary icons for Mercurius. [License](https://github.com/pedrolemoz/unicons-flutter/blob/master/LICENSE)\n\nIII. Weather Service Declaration\n1. Mercurius introduced [QWeather](https://www.qweather.com) drives Mercurius' weather service.`
  String get importDeclarationContent {
    return Intl.message(
      'Welcome to Mercurius software and services from Cierra_Runis. \n\nThis time, Cierra_Runis has prepared the "Mercurius Introduction Declaration" (hereinafter referred to as "the declaration"). \n\nI. Font Declaration\n1. Mercurius introduced Saira font as the main font of Mercurius. [License](https://github.com/Omnibus-Type/Saira/blob/master/OFL.txt)\n\nII. Icon Declaration\n1. Mercurius introduced Material Icons as the main icon of Mercurius. [License](https://github.com/qwd/Icons/blob/main/LICENSE)\n2. Mercurius introduced unicons as secondary icons for Mercurius. [License](https://github.com/pedrolemoz/unicons-flutter/blob/master/LICENSE)\n\nIII. Weather Service Declaration\n1. Mercurius introduced [QWeather](https://www.qweather.com) drives Mercurius\' weather service.',
      name: 'importDeclarationContent',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Statement`
  String get privacyStatement {
    return Intl.message(
      'Privacy Statement',
      name: 'privacyStatement',
      desc: '',
      args: [],
    );
  }

  /// `Updated on July 12, 2023`
  String get privacyStatementContentUpdateTime {
    return Intl.message(
      'Updated on July 12, 2023',
      name: 'privacyStatementContentUpdateTime',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Mercurius software and services from Cierra_Runis.\n\nIn order to better protect your personal information, please read this policy carefully.\n\nIf you have any objections or questions about this policy, you can communicate with Cierra_Runis through the contact information published in Article 5 of this policy.\n\nI. Introduction\n1. This policy applies to Mercurius multi-platform applications.\n2. Please read carefully and fully understand the entire content of this policy before using Mercurius' services. Once you continue to use Mercurius software and services, you have agreed to Cierra_Runis using and processing your relevant information in accordance with this policy.\n3. Cierra_Runis will update this policy from time to time in accordance with relevant laws and regulations. After this policy is updated and changed, please confirm the new content of this policy.\n4. Please agree and understand that only after you confirm the changed policy, Cierra_Runis will collect, use, store, and process your personal information in accordance with the updated policy; you have the right to refuse to update the changed policy . But please be aware that once you refuse to agree to the changed policy, you will not be able to continue to use Mercurius related services and functions in full.\n\nII. About Cierra_Runis\n1. Mercurius is provided by Cierra_Runis personally.\n2. The basic information of Cierra_Runis is as follows: Personal website is [https://github.com/Cierra-Runis](https://github.com/Cierra-Runis).\n\nIII. Mercurius' information policy\n1. All data generated by Mercurius are stored locally, and any data generated by Mercurius will not be uploaded, including your diary and images.\n\nIV. scope of application\n1. All services of Cierra_Runis are applicable to this policy. If there is any inconsistency between this policy and the privacy guidelines or statements of specific services, this policy shall prevail.\n\nV. Contact Cierra_Runis\n1. If you have any questions about the content of this policy or the privacy protection-related matters you encounter when using Cierra_Runis' services, or make inquiries or complaints, you can use any of the following methods Get in touch with Cierra_Runis:\n- You can reach us in the Mercurius About page\n- You can write to [byrdsaron@gmail.com](byrdsaron@gmail.com)`
  String get privacyStatementContent {
    return Intl.message(
      'Welcome to Mercurius software and services from Cierra_Runis.\n\nIn order to better protect your personal information, please read this policy carefully.\n\nIf you have any objections or questions about this policy, you can communicate with Cierra_Runis through the contact information published in Article 5 of this policy.\n\nI. Introduction\n1. This policy applies to Mercurius multi-platform applications.\n2. Please read carefully and fully understand the entire content of this policy before using Mercurius\' services. Once you continue to use Mercurius software and services, you have agreed to Cierra_Runis using and processing your relevant information in accordance with this policy.\n3. Cierra_Runis will update this policy from time to time in accordance with relevant laws and regulations. After this policy is updated and changed, please confirm the new content of this policy.\n4. Please agree and understand that only after you confirm the changed policy, Cierra_Runis will collect, use, store, and process your personal information in accordance with the updated policy; you have the right to refuse to update the changed policy . But please be aware that once you refuse to agree to the changed policy, you will not be able to continue to use Mercurius related services and functions in full.\n\nII. About Cierra_Runis\n1. Mercurius is provided by Cierra_Runis personally.\n2. The basic information of Cierra_Runis is as follows: Personal website is [https://github.com/Cierra-Runis](https://github.com/Cierra-Runis).\n\nIII. Mercurius\' information policy\n1. All data generated by Mercurius are stored locally, and any data generated by Mercurius will not be uploaded, including your diary and images.\n\nIV. scope of application\n1. All services of Cierra_Runis are applicable to this policy. If there is any inconsistency between this policy and the privacy guidelines or statements of specific services, this policy shall prevail.\n\nV. Contact Cierra_Runis\n1. If you have any questions about the content of this policy or the privacy protection-related matters you encounter when using Cierra_Runis\' services, or make inquiries or complaints, you can use any of the following methods Get in touch with Cierra_Runis:\n- You can reach us in the Mercurius About page\n- You can write to [byrdsaron@gmail.com](byrdsaron@gmail.com)',
      name: 'privacyStatementContent',
      desc: '',
      args: [],
    );
  }

  /// `Create New Diary`
  String get createNewDiary {
    return Intl.message(
      'Create New Diary',
      name: 'createNewDiary',
      desc: '',
      args: [],
    );
  }

  /// `Continue Editing Diary`
  String get continueEditingDiary {
    return Intl.message(
      'Continue Editing Diary',
      name: 'continueEditingDiary',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Word Count`
  String get monthlyWordCountStatistics {
    return Intl.message(
      'Monthly Word Count',
      name: 'monthlyWordCountStatistics',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{{count} Word} other{{count} Words}}`
  String wordCount(int count) {
    return Intl.plural(
      count,
      one: '$count Word',
      other: '$count Words',
      name: 'wordCount',
      desc: 'Word count of a diary',
      args: [count],
    );
  }

  /// `{count, plural, =1{{count} Diary} other{{count} Diaries}}`
  String diaryCount(int count) {
    return Intl.plural(
      count,
      one: '$count Diary',
      other: '$count Diaries',
      name: 'diaryCount',
      desc: 'Diary count in a certain time period',
      args: [count],
    );
  }

  /// `Unknown Version`
  String get unknownVersion {
    return Intl.message(
      'Unknown Version',
      name: 'unknownVersion',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Get Version`
  String get failedToGetVersion {
    return Intl.message(
      'Failed To Get Version',
      name: 'failedToGetVersion',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete the diary?`
  String get areYouSureToDeleteTheDiary {
    return Intl.message(
      'Confirm delete the diary?',
      name: 'areYouSureToDeleteTheDiary',
      desc: '',
      args: [],
    );
  }

  /// `Please think twice about deleting the diary`
  String get pleaseThinkTwiceAboutDeletingTheDiary {
    return Intl.message(
      'Please think twice about deleting the diary',
      name: 'pleaseThinkTwiceAboutDeletingTheDiary',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete the image?`
  String get areYouSureToDeleteTheImage {
    return Intl.message(
      'Confirm delete the image?',
      name: 'areYouSureToDeleteTheImage',
      desc: '',
      args: [],
    );
  }

  /// `Please think twice about deleting the image`
  String get pleaseThinkTwiceAboutDeletingTheImage {
    return Intl.message(
      'Please think twice about deleting the image',
      name: 'pleaseThinkTwiceAboutDeletingTheImage',
      desc: '',
      args: [],
    );
  }

  /// `Insert the image from...`
  String get insertTheImageFrom {
    return Intl.message(
      'Insert the image from...',
      name: 'insertTheImageFrom',
      desc: '',
      args: [],
    );
  }

  /// `System File`
  String get systemFile {
    return Intl.message(
      'System File',
      name: 'systemFile',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get mood {
    return Intl.message(
      'Mood',
      name: 'mood',
      desc: '',
      args: [],
    );
  }

  /// `{mood, select, other{Unknown Mood} smile{Happy} angry{Angry} confused{Confused} frown{Frown} laughing{Laughing} silentSquint{Silent Squint} sadCrying{Sad Crying} smileDizzy{Smile Dizzy} normal{Normal}}`
  String moodText(String mood) {
    return Intl.select(
      mood,
      {
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
      },
      name: 'moodText',
      desc: 'Get mood text by mood in [DiaryMoodType]',
      args: [mood],
    );
  }

  /// `How is your mood now?`
  String get howIsYourMoodNow {
    return Intl.message(
      'How is your mood now?',
      name: 'howIsYourMoodNow',
      desc: '',
      args: [],
    );
  }

  /// `ねぇ、今どんな気持ち`
  String get howIsYourMoodNowDescription {
    return Intl.message(
      'ねぇ、今どんな気持ち',
      name: 'howIsYourMoodNowDescription',
      desc: '',
      args: [],
    );
  }

  /// `Weather`
  String get weather {
    return Intl.message(
      'Weather',
      name: 'weather',
      desc: '',
      args: [],
    );
  }

  /// `{weather, select, other{Unknown Weather} sunny{Sunny} cloudy{Cloudy} fewClouds{Few Clouds} heavyThunderstorm{Heavy Thunderstorm} lightRain{Light Rain} heavyRain{Heavy Rain} lightSnow{Light Snow} heavySnow{Heavy Snow} foggy{Foggy}}`
  String weatherText(String weather) {
    return Intl.select(
      weather,
      {
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
      },
      name: 'weatherText',
      desc: 'Get weather text by weather in [DiaryWeatherType]',
      args: [weather],
    );
  }

  /// `What is the weather now?`
  String get whatIsTheWeatherNow {
    return Intl.message(
      'What is the weather now?',
      name: 'whatIsTheWeatherNow',
      desc: '',
      args: [],
    );
  }

  /// `今日もいい天気`
  String get whatIsTheWeatherNowDescription {
    return Intl.message(
      '今日もいい天気',
      name: 'whatIsTheWeatherNowDescription',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Image Format`
  String get unsupportedImageFormat {
    return Intl.message(
      'Unsupported Image Format',
      name: 'unsupportedImageFormat',
      desc: '',
      args: [],
    );
  }

  /// `Image Missing`
  String get imageMissing {
    return Intl.message(
      'Image Missing',
      name: 'imageMissing',
      desc: '',
      args: [],
    );
  }

  /// `Search Diary`
  String get searchDiary {
    return Intl.message(
      'Search Diary',
      name: 'searchDiary',
      desc: '',
      args: [],
    );
  }

  /// `Search Title`
  String get searchTitle {
    return Intl.message(
      'Search Title',
      name: 'searchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Go Back Again To Exit`
  String get backAgainToExit {
    return Intl.message(
      'Go Back Again To Exit',
      name: 'backAgainToExit',
      desc: '',
      args: [],
    );
  }

  /// `This service is provided by Hitokoto「一言」`
  String get hiToKoToProvider {
    return Intl.message(
      'This service is provided by Hitokoto「一言」',
      name: 'hiToKoToProvider',
      desc: '',
      args: [],
    );
  }

  /// `Fetching 「一言」...`
  String get hiToKoToFetching {
    return Intl.message(
      'Fetching 「一言」...',
      name: 'hiToKoToFetching',
      desc: '',
      args: [],
    );
  }

  /// `This Day Last Year`
  String get thisDayLastYear {
    return Intl.message(
      'This Day Last Year',
      name: 'thisDayLastYear',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<MercuriusL10N> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<MercuriusL10N> load(Locale locale) => MercuriusL10N.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
