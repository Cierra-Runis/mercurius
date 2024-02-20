import 'package:mercurius/index.dart';
import 'package:path/path.dart' as path;

class ExportSection extends ConsumerWidget {
  const ExportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return BasedListSection(
      titleText: l10n.export,
      children: [
        BasedListTile(
          leadingIcon: Icons.data_object_rounded,
          titleText: l10n.exportJsonFile,
          onTap: () async {
            final dir = await ref.watch(mercuriusPathProvider.future);
            final path = '$dir/export.json';
            await isarService.exportJsonWith(path);

            /// FIXME: https://github.com/fluttercommunity/plus_plugins/issues/1351
            await Share.shareFiles([path]);
          },
        ),
        const _V2Tile(),
        BasedListTile(
          leadingIcon: Icons.nfc_rounded,
          titleText: l10n.exportNfcData,
          // TODO: 写逻辑
          subtitleText: l10n.notYetCompleted,
        ),
      ],
    );
  }
}

class _V2Tile extends ConsumerWidget {
  const _V2Tile();

  Future<List<Map<String, dynamic>>> convert() async {
    final codePointTag = {
      0xf51a: 'accessTime',
      0xf519: 'accessTimeFilled',
      0xf517: 'accessAlarm',
      0xf520: 'accountBalanceWallet',
      0xf524: 'adUnits',
      0xee98: 'assignment',
      0xf591: 'attractions',
      0xf593: 'audiotrack',
      0xf596: 'autoAwesome',
      0xf5a5: 'badge',
      0xf02e0: 'balance',
      0xf5ac: 'bathtub',
      0xf5b3: 'beachAccess',
      0xf5b4: 'bed',
    };

    final diaries = await isarService.getAllDiaries();
    final result = <Map<String, dynamic>>[];

    for (final diary in diaries) {
      final contents = jsonDecode(
        diary.contentJsonString,
      ) as List<dynamic>;

      for (final content in contents) {
        try {
          if (content['insert'] is String) continue;
          final embed = content['insert'] as Map<String, dynamic>;
          if (!embed.containsKey('mercuriusTag')) continue;

          final j = jsonDecode(embed['mercuriusTag']);
          content['insert']['mercuriusTag'] = {
            'tagType': codePointTag[j['codePoint']],
            'message': j['message'],
          };
        } catch (e) {
          App.printLog('Error $content', error: e);
        }
      }

      final s = {
        'id': diary.id,
        'belongTo': diary.createDateTime.microsecondsSinceEpoch,
        'createAt': diary.createDateTime.microsecondsSinceEpoch,
        'editAt': diary.latestEditTime.microsecondsSinceEpoch,
        'content': contents,
        'editing': diary.editing,
        'title': diary.titleString,
        'moodType': diary.moodType.mood,
        'weatherType': diary.weatherType.weather,
      };

      result.add(s);
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> images(String imageDir) async {
    final result = <Map<String, dynamic>>[];
    for (final file in Directory(imageDir).listSync()) {
      if (file is File) {
        result.add({
          'filename': path.basename(file.path),
          'data': base64.encode(file.readAsBytesSync()),
        });
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return BasedListTile(
      leadingIcon: Icons.looks_two_rounded,
      titleText: l10n.exportV2Files,
      subtitleText: l10n.v2Files,
      onTap: () async {
        final dir = await ref.read(mercuriusPathProvider.future);
        final diaryList = await convert();
        final imageList = await images('$dir/image');
        final shares = <XFile>[];

        try {
          final diary = File('$dir/v2_diary.json');
          await diary.writeAsString(jsonEncode(diaryList));
          shares.add(XFile('$dir/v2_diary.json'));
        } catch (e) {
          App.printLog('v2_diary Error', error: e);
        }

        try {
          final image = File('$dir/image.json');
          await image.writeAsString(jsonEncode(imageList));
          shares.add(XFile('$dir/image.json'));
        } catch (e) {
          App.printLog('image Error', error: e);
        }

        try {
          Share.shareXFiles(shares);
        } catch (e) {
          App.printLog('share error', error: e);
        }
      },
    );
  }
}
