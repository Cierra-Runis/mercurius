import 'package:mercurius/index.dart';

class MercuriusIOPage extends StatelessWidget {
  const MercuriusIOPage({super.key});

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.importAndExport),
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
