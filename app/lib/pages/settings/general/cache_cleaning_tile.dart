part of 'general_section.dart';

class _CacheCleaningTile extends ConsumerWidget {
  const _CacheCleaningTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);
    final appCache = paths.appCache;
    return BasedListTile(
      leadingIcon: Icons.cleaning_services_rounded,
      titleText: l10n.cacheCleaning,
      onTap: () async {
        final files = appCache.listSync();
        for (final file in files) {
          try {
            file.delete(recursive: true);
          } catch (e) {
            App.printLog('File / Directory delete Failed', error: e);
          }
        }
        ref.invalidate(pathsProvider);
      },
      detailText: Bytes.format(bytes: appCache.getBytes()),
    );
  }
}
