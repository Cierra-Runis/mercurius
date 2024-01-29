import 'package:mercurius/index.dart';

class IOPage extends StatelessWidget {
  const IOPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.importAndExport),
      ),
      body: const BasedListView(
        children: [
          _ImportSection(),
          _ExportSection(),
        ],
      ),
    );
  }
}

class _ImportSection extends ConsumerWidget {
  const _ImportSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.import,
      children: [
        BasedListTile(
          leadingIcon: Icons.data_object_rounded,
          titleText: l10n.importJsonFile,
          onTap: () async {
            /// TIPS: 需要清除缓存，否则使用选择的和以前一样名称的文件
            if (Platform.isAndroid || Platform.isIOS) {
              await FilePicker.platform.clearTemporaryFiles();
            }

            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['json'],
            );

            if (result != null && result.files.single.path != null) {
              final succuss = await isarService.importJsonWith(
                result.files.single.path!,
              );

              if (context.mounted && succuss) {
                App.vibration();
                Flushbar(
                  icon: const Icon(UniconsLine.smile),
                  isDismissible: false,
                  messageText: Center(
                    child: Text(
                      l10n.pleaseBackToHomePage,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(60, 16, 60, 0),
                  barBlur: 1.0,
                  borderRadius: BorderRadius.circular(16),
                  backgroundColor: context.colorScheme.outline.withAlpha(16),
                  boxShadows: const [
                    BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 16),
                    ),
                  ],
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  flushbarPosition: FlushbarPosition.TOP,
                ).show(context);
              }
            }
          },
        ),
        BasedListTile(
          leadingIcon: Icons.nfc_rounded,
          titleText: l10n.importNfcData,
          // TODO: 写逻辑
          subtitleText: l10n.notYetCompleted,
        ),
      ],
    );
  }
}

class _ExportSection extends ConsumerWidget {
  const _ExportSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);

    return BasedListSection(
      titleText: l10n.export,
      children: [
        BasedListTile(
          leadingIcon: Icons.data_object_rounded,
          titleText: l10n.exportJsonFile,
          onTap: () async {
            final path = join(paths.temp.path, 'export.json');
            final json = await isarService.exportDiaryJson();
            await File(path).writeAsString(jsonEncode(json));
            await Share.shareXFiles([XFile(path)]);
          },
        ),
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