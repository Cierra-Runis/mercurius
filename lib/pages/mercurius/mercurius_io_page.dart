import 'package:mercurius/index.dart';

class MercuriusIOPage extends StatelessWidget {
  const MercuriusIOPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导入导出'),
      ),
      body: const MercuriusListWidget(
        children: [
          MercuriusImportSectionWidget(),
          MercuriusExportSectionWidget(),
        ],
      ),
    );
  }
}
