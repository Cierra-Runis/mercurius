import 'package:mercurius/index.dart';

class IOPage extends StatelessWidget {
  const IOPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.importAndExport),
      ),
      body: const BasedListView(
        children: [
          MercuriusImportSectionWidget(),
          MercuriusExportSectionWidget(),
        ],
      ),
    );
  }
}
