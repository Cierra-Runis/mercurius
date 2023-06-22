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

  static String m1(mood) => "${Intl.select(mood, {
            'other': '未知の気分',
            'smile': 'ハッピー',
            'angry': '怒り',
            'confused': '混乱',
            'frown': 'しかめっ面',
            'laughing': '大笑い',
            'silentSquint': '辛い',
            'sadCrying': '悲しい泣く',
            'smileDizzy': '死にたい',
            'normal': '普通',
          })}";

  static String m2(weather) => "${Intl.select(weather, {
            'other': '未知',
            'sunny': '晴れ',
            'cloudy': '曇り',
            'fewClouds': '雲が少ない',
            'heavyThunderstorm': '激しい雷雨',
            'lightRain': '小雨',
            'heavyRain': '大雨',
            'lightSnow': '小雪',
            'heavySnow': '大雪',
            'foggy': '霧',
          })}";

  static String m3(count) => "${count} 文字";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("アプリについて"),
        "alreadyTheLatestVersion":
            MessageLookupByLibrary.simpleMessage("すでに最新"),
        "alwaysBright": MessageLookupByLibrary.simpleMessage("常に明るい"),
        "alwaysDark": MessageLookupByLibrary.simpleMessage("常に暗い"),
        "areYouSureToDeleteTheDiary":
            MessageLookupByLibrary.simpleMessage("日記を削除してもよろしいですか？"),
        "areYouSureToDeleteTheImage":
            MessageLookupByLibrary.simpleMessage("画像を削除してもよろしいですか？"),
        "back": MessageLookupByLibrary.simpleMessage("戻る"),
        "backAgainToExit": MessageLookupByLibrary.simpleMessage("もう一度戻って終了します"),
        "buttonVibration": MessageLookupByLibrary.simpleMessage("ボタン振動"),
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "changeDate": MessageLookupByLibrary.simpleMessage("日付を変える"),
        "changeMood": MessageLookupByLibrary.simpleMessage("気分を変える"),
        "changeWeather": MessageLookupByLibrary.simpleMessage("天気を変える"),
        "clickHereToUpgrade": MessageLookupByLibrary.simpleMessage("アップグレード"),
        "confirm": MessageLookupByLibrary.simpleMessage("確認"),
        "contactUs": MessageLookupByLibrary.simpleMessage("お問い合わせ"),
        "content": MessageLookupByLibrary.simpleMessage("内容"),
        "contentCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("コンテンツを空にすることはできません"),
        "createNewDiary": MessageLookupByLibrary.simpleMessage("日記を追加"),
        "darkMode": MessageLookupByLibrary.simpleMessage("ダークモード"),
        "diaryCount": m0,
        "disabled": MessageLookupByLibrary.simpleMessage("無効"),
        "enabled": MessageLookupByLibrary.simpleMessage("有効"),
        "export": MessageLookupByLibrary.simpleMessage("輸出"),
        "exportJsonFile":
            MessageLookupByLibrary.simpleMessage("JSON ファイルをエクスポートする"),
        "exportNfcData":
            MessageLookupByLibrary.simpleMessage("NFC データをエクスポートする"),
        "failedToGetVersion":
            MessageLookupByLibrary.simpleMessage("バージョンの取得に失敗しました"),
        "followTheSystem": MessageLookupByLibrary.simpleMessage("システムに従います"),
        "hiToKoToFetching": MessageLookupByLibrary.simpleMessage("「一言」を取得中"),
        "hiToKoToProvider": MessageLookupByLibrary.simpleMessage(
            "このサービスは、Hitokoto「一言」が提供しています"),
        "homePage": MessageLookupByLibrary.simpleMessage("ホーム"),
        "howIsYourMoodNow": MessageLookupByLibrary.simpleMessage("今の気分は？"),
        "howIsYourMoodNowDescription":
            MessageLookupByLibrary.simpleMessage("ねぇ、今どんな気持ち"),
        "imageGallery": MessageLookupByLibrary.simpleMessage("画廊"),
        "imageMissing": MessageLookupByLibrary.simpleMessage("画像がありません"),
        "import": MessageLookupByLibrary.simpleMessage("輸入"),
        "importAndExport": MessageLookupByLibrary.simpleMessage("データの輸出入"),
        "importDeclaration":
            MessageLookupByLibrary.simpleMessage("インポートに関する声明"),
        "importDeclarationContent": MessageLookupByLibrary.simpleMessage(
            "Cierra_Runis の Mercurius ソフトウェアおよびサービスへようこそ。\n\nこの度、Cierra_Runis は「Mercurius インポートに関する声明」（以下「本声明」といいます）を作成いたしました。\n\n一、フォントに関する声明\n1. Mercurius は、Mercurius のメイン フォントとして Saira フォントを導入しました。[ライセンス](https://github.com/Omnibus-Type/Sira/blob/master/OFL.txt)\n\n二、アイコンに関する声明\n1. Mercurius は、Mercurius のメイン アイコンとしてマテリアル アイコンを導入しました。[ライセンス](https://github.com/qwd/Icons/blob/main/LICENSE)\n2. Mercurius は、Mercurius の二次アイコンとしてユニコンを導入しました。[ライセンス](https://github.com/pedrolemoz/unicons-flutter/blob/master/LICENSE)\n\n三、気象サービスに関する声明\n1. Mercurius は、Mercurius の気象サービスを推進するために [QWeather](https://www.qweather.com) を導入しました。"),
        "importDeclarationContentUpdateTime":
            MessageLookupByLibrary.simpleMessage("2023 年 6 月 4 日更新"),
        "importDeclarationDescription":
            MessageLookupByLibrary.simpleMessage("フォント、アイコン、気象サービス関連"),
        "importJsonFile":
            MessageLookupByLibrary.simpleMessage("JSON ファイルをインポートする"),
        "importNfcData":
            MessageLookupByLibrary.simpleMessage("NFC データをインポートする"),
        "insertImage": MessageLookupByLibrary.simpleMessage("図を挿入"),
        "insertTheImageFrom":
            MessageLookupByLibrary.simpleMessage("どこから画像を挿入すればよいですか？"),
        "insertTime": MessageLookupByLibrary.simpleMessage("時間を挿入"),
        "monthlyWordCountStatistics":
            MessageLookupByLibrary.simpleMessage("月度文字数統計"),
        "mood": MessageLookupByLibrary.simpleMessage("気分"),
        "moodText": m1,
        "morePage": MessageLookupByLibrary.simpleMessage("詳細"),
        "noData": MessageLookupByLibrary.simpleMessage("データ無し"),
        "notYetCompleted": MessageLookupByLibrary.simpleMessage("まだ完成していません"),
        "pleaseBackToHomePage":
            MessageLookupByLibrary.simpleMessage("ホームページに戻ってください"),
        "pleaseThinkTwiceAboutDeletingTheDiary":
            MessageLookupByLibrary.simpleMessage("日記を削除するかどうかよく考えてください"),
        "pleaseThinkTwiceAboutDeletingTheImage":
            MessageLookupByLibrary.simpleMessage("画像を削除するかどうかよく考えてください"),
        "privacyStatement":
            MessageLookupByLibrary.simpleMessage("プライバシーに関する声明"),
        "privacyStatementContent": MessageLookupByLibrary.simpleMessage(
            "Cierra_Runis の Mercurius ソフトウェアおよびサービスへようこそ。\n\nお客様の個人情報をより適切に保護するために、このポリシーをよくお読みください。\n\nこのポリシーに関して異議や質問がある場合は、このポリシーの第 5 条に掲載されている連絡先情報を通じて Cierra_Runis と連絡を取ることができます。\n\n一、はじめに\n1. このポリシーは、Mercurius Android アプリに適用されます。\n2. メルクリウスのサービスをご利用いただく前に、本ポリシーをよくお読みいただき、内容を十分にご理解ください。Mercurius ソフトウェアおよびサービスの使用を継続すると、Cierra_Runis がこのポリシーに従って関連情報を使用および処理することに同意したことになります。\n3. Cierra_Runis は、関連法令等に基づき本ポリシーを随時更新しますので、本ポリシーが更新・変更された場合には、新たな本ポリシーの内容をご確認ください。\n4. お客様が変更されたポリシーを確認した場合にのみ、Cierra_Runis が更新されたポリシーに従ってお客様の個人情報を収集、使用、保管、および処理することに同意し、ご理解ください。お客様には、更新されたポリシーを拒否する権利があります。ただし、変更後のポリシーへの同意を拒否すると、Mercurius 関連のサービスおよび機能を完全に利用し続けることができなくなりますので、ご注意ください。\n\n二、Cierra_Runis について\n1. Mercurius は、Cierra_Runis によって個人的にソフトウェアサービスとして提供されます。\n2. Cierra_Runis の基本情報は以下のとおりです。個人 Web サイトは [https://github.com/Cierra-Runis](https://github.com/Cierra-Runis) です。\n\n三、Mercurius の情報ポリシー\n1. Mercurius によって生成されたすべてのデータはローカルに保存され、日記や画像など、Mercurius によって生成されたデータはアップロードされません。\n\n四、適用範囲\n1. Cierra_Runis のすべてのサービスはこのポリシーの対象となります。このポリシーとプライバシーガイドラインまたは特定のサービスの声明との間に矛盾がある場合、このポリシーが優先されるものとします。\n\n五、Cierra_Runis に連絡する\n1. 本ポリシーの内容や Cierra_Runis のサービス利用時に発生するプライバシー保護関連事項に関してご質問、お問い合わせや苦情がある場合は、以下のいずれかの方法で Cierra_Runis にお問い合わせいただけます。\n- Mercurius のアバウトパージからお問い合わせいただけます。\n- [byrdsaron@gmail.com](byrdsaron@gmail.com) にメールを送信できます。"),
        "privacyStatementContentUpdateTime":
            MessageLookupByLibrary.simpleMessage("2023 年 6 月 4 日更新"),
        "releasePage": MessageLookupByLibrary.simpleMessage("リリースページ"),
        "releasePageOops":
            MessageLookupByLibrary.simpleMessage("おっと! ページを更新してください！"),
        "save": MessageLookupByLibrary.simpleMessage("保存"),
        "searchDiaryContent":
            MessageLookupByLibrary.simpleMessage("日記の内容を検索する"),
        "settings": MessageLookupByLibrary.simpleMessage("设定"),
        "statistics": MessageLookupByLibrary.simpleMessage("統計データ"),
        "systemFile": MessageLookupByLibrary.simpleMessage("システムファイル"),
        "title": MessageLookupByLibrary.simpleMessage("タイトル"),
        "unknownVersion": MessageLookupByLibrary.simpleMessage("不明なバージョン"),
        "unsupportedImageFormat":
            MessageLookupByLibrary.simpleMessage("サポートされていない画像フォーマット"),
        "untitled": MessageLookupByLibrary.simpleMessage("タイトル無し"),
        "weather": MessageLookupByLibrary.simpleMessage("天気"),
        "weatherText": m2,
        "whatIsTheWeatherNow": MessageLookupByLibrary.simpleMessage("今の天気は？"),
        "whatIsTheWeatherNowDescription":
            MessageLookupByLibrary.simpleMessage("今日もいい天気"),
        "wordCount": m3,
        "writingSomethingHere": MessageLookupByLibrary.simpleMessage("何かを書けよ…")
      };
}
