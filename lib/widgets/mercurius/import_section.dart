import 'package:mercurius/index.dart';

class ImportSection extends ConsumerWidget {
  const ImportSection({super.key});

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
            if (Platform.isAndroid) {
              await FilePicker.platform.clearTemporaryFiles();
            }
            final result = await FilePicker.platform.pickFiles();
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
