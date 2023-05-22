import 'package:mercurius/index.dart';

class MercuriusImportSectionWidget extends ConsumerWidget {
  const MercuriusImportSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MercuriusListSectionWidget(
      title: const Text('导入'),
      children: [
        MercuriusListItemWidget(
          iconData: Icons.data_object_rounded,
          titleText: '导入 json 文件',
          onTap: () async {
            /// TIPS: 需要清除缓存，否则使用选择的和以前一样名称的文件
            await FilePicker.platform.clearTemporaryFiles();
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              isarService.importJsonWith(result.files.single.path!);
            }
            if (context.mounted) {
              Mercurius.vibration(ref: ref, duration: 300);
              Flushbar(
                icon: const Icon(UniconsLine.smile),
                isDismissible: false,
                messageText: const Center(
                  child: Text(
                    '请回到主页检查',
                    style: TextStyle(
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
          },
        ),
        const MercuriusListItemWidget(
          iconData: Icons.nfc_rounded,
          titleText: '导入 NFC 数据',
          // TODO: 写逻辑
          summaryText: '暂未完成',
        ),
      ],
    );
  }
}
