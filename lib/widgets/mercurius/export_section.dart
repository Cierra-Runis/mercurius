import 'package:mercurius/index.dart';

class ExportSection extends ConsumerWidget {
  const ExportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return BasedListSection(
      titleText: l10n.export,
      children: [
        BasedListTile(
          leadingIcon: Icons.data_object_rounded,
          titleText: l10n.exportJsonFile,
          onTap: () async {
            final dir = await ref.watch(mercuriusPathProvider.future);
            final path = '$dir/export.json';
            await isarService.exportDiaryWith(path);

            /// FIXME: https://github.com/fluttercommunity/plus_plugins/issues/1351

            await Share.shareFiles([path]);
          },
        ),
        BasedListTile(
          leadingIcon: Icons.nfc_rounded,
          titleText: l10n.exportNfcData,
          // TODO: 写逻辑
          subtitleText: l10n.notYetCompleted,
        ),
      ],
    );
  }
}
