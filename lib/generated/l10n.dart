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

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
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

  /// `Untitled`
  String get untitled {
    return Intl.message(
      'Untitled',
      name: 'untitled',
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

  /// `Insert Time`
  String get insertTime {
    return Intl.message(
      'Insert Time',
      name: 'insertTime',
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

  /// `Import & Export`
  String get importAndExport {
    return Intl.message(
      'Import & Export',
      name: 'importAndExport',
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

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Content cannot be empty`
  String get contentCannotBeEmpty {
    return Intl.message(
      'Content cannot be empty',
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

  /// `Create New Diary`
  String get createNewDiary {
    return Intl.message(
      'Create New Diary',
      name: 'createNewDiary',
      desc: '',
      args: [],
    );
  }

  /// `Monthly word count statistics`
  String get monthlyWordCountStatistics {
    return Intl.message(
      'Monthly word count statistics',
      name: 'monthlyWordCountStatistics',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{{count} word} other{{count} words}}`
  String wordCount(int count) {
    return Intl.plural(
      count,
      one: '$count word',
      other: '$count words',
      name: 'wordCount',
      desc: 'Word count of a diary',
      args: [count],
    );
  }

  /// `{count, plural, =1{{count} diary} other{{count} diaries}}`
  String diaryCount(int count) {
    return Intl.plural(
      count,
      one: '$count diary',
      other: '$count diaries',
      name: 'diaryCount',
      desc: 'Diary count in a certain time period',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
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
  Future<S> load(Locale locale) => S.load(locale);
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
