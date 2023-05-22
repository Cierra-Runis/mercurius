import 'package:mercurius/index.dart';

class MercuriusExportSectionWidget extends ConsumerWidget {
  const MercuriusExportSectionWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MercuriusListSectionWidget(
      title: const Text('导出'),
      children: [
        MercuriusListItemWidget(
          iconData: Icons.data_object_rounded,
          titleText: '导出 json 文件',
          onTap: () async {
            String path =
                '${await ref.watch(mercuriusPathProvider.future)}/export.json';
            isarService.exportJsonWith(path);
            Share.shareXFiles([XFile(path)]);
          },
        ),
        const MercuriusListItemWidget(
          iconData: Icons.nfc_rounded,
          titleText: '导出 NFC 数据',
          // TODO: 写逻辑
          summaryText: '暂未完成',
        ),
      ],
    );
  }
}
