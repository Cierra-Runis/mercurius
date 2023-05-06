import 'package:mercurius/index.dart';

class MercuriusOriginalExportSectionWidget extends StatelessWidget {
  const MercuriusOriginalExportSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MercuriusModifiedListSection(
      title: const Text('导出'),
      children: [
        MercuriusModifiedListItem(
          iconData: Icons.data_object_rounded,
          titleText: '导出 json 文件',
          onTap: () async {
            String path = '${mercuriusPathNotifier.path}/export.json';
            isarService.exportJsonWith(path);
            Share.shareXFiles([XFile(path)]);
          },
        ),
        const MercuriusModifiedListItem(
          iconData: Icons.nfc_rounded,
          titleText: '导出 NFC 数据',
          // TODO: 写逻辑
          summaryText: '暂未完成',
        ),
      ],
    );
  }
}
