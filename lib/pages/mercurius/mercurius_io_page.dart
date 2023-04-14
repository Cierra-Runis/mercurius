import 'package:mercurius/index.dart';

class MercuriusIoPage extends StatelessWidget {
  const MercuriusIoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导入导出'),
      ),
      body: const MercuriusModifiedList(
        children: [
          MercuriusModifiedListSection(
            title: Text('导入'),
            children: [
              MercuriusModifiedListItem(
                iconData: Icons.data_object_rounded,
                titleText: '导入 json 文件',
              ),
              MercuriusModifiedListItem(
                iconData: Icons.nfc_rounded,
                titleText: '导入 NFC 数据',
              ),
            ],
          ),
          MercuriusModifiedListSection(
            title: Text('导出'),
            children: [
              MercuriusModifiedListItem(
                iconData: Icons.data_object_rounded,
                titleText: '导出 json 文件',
              ),
              MercuriusModifiedListItem(
                iconData: Icons.nfc_rounded,
                titleText: '导出 NFC 数据',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
