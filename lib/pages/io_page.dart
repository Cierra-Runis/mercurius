import 'package:mercurius/index.dart';

class IOPage extends StatelessWidget {
  const IOPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.current;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.importAndExport),
      ),
      body: const BasedListView(
        children: [
          ImportSection(),
          ExportSection(),
        ],
      ),
    );
  }
}
