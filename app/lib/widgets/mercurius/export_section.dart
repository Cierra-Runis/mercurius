import '../../../app/lib/index.dart';

class ExportSection extends ConsumerWidget {
  const ExportSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final paths = ref.watch(pathsProvider);

    return BasedListSection(
      titleText: l10n.export,
      children: [
        BasedListTile(
          leadingIcon: Icons.data_object_rounded,
          titleText: l10n.exportJsonFile,
          onTap: () async {
            final path = join(paths.temp.path, 'export.json');
            final json = await isarService.exportDiaryJson();
            await File(path).writeAsString(jsonEncode(json));
            await Share.shareXFiles([XFile(path)]);
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
