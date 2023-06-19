import 'package:mercurius/index.dart';

class MercuriusImportSectionWidget extends ConsumerWidget {
  const MercuriusImportSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S localizations = S.of(context);

    return MercuriusListSectionWidget(
      title: Text(localizations.import),
      children: [
        MercuriusListItemWidget(
          iconData: Icons.data_object_rounded,
          titleText: localizations.importJsonFile,
          onTap: () async {
            /// TIPS: 需要清除缓存，否则使用选择的和以前一样名称的文件
            await FilePicker.platform.clearTemporaryFiles();
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null && result.files.single.path != null) {
              bool succuss = await isarService.importJsonWith(
                result.files.single.path!,
              );
              if (context.mounted && succuss) {
                Mercurius.vibration(ref: ref, duration: 300);
                Flushbar(
                  icon: const Icon(UniconsLine.smile),
                  isDismissible: false,
                  messageText: Center(
                    child: Text(
                      localizations.pleaseBackToHomePage,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(60, 16, 60, 0),
                  barBlur: 1.0,
                  borderRadius: BorderRadius.circular(16),
                  backgroundColor:
                      Theme.of(context).colorScheme.outline.withAlpha(16),
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
        MercuriusListItemWidget(
          iconData: Icons.nfc_rounded,
          titleText: localizations.importNfcData,
          // TODO: 写逻辑
          summaryText: localizations.notYetCompleted,
        ),
      ],
    );
  }
}
