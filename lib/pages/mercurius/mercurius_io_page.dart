import 'package:mercurius/index.dart';

class MercuriusIOPage extends StatelessWidget {
  const MercuriusIOPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导入导出'),
      ),
      body: MercuriusModifiedList(
        children: [
          MercuriusModifiedListSection(
            title: const Text('导入'),
            children: [
              MercuriusModifiedListItem(
                iconData: Icons.data_object_rounded,
                titleText: '导入 json 文件',
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    isarService.importJsonWith(result.files.single.path!);
                  }
                  if (context.mounted) {
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
              const MercuriusModifiedListItem(
                iconData: Icons.nfc_rounded,
                titleText: '导入 NFC 数据',
                summaryText: '暂未完成',
              ),
            ],
          ),
          MercuriusModifiedListSection(
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
                summaryText: '暂未完成',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
