import 'package:mercurius/index.dart';

class HiToKoToWidget extends ConsumerWidget {
  const HiToKoToWidget({super.key});

  /// FIXME: 当组件被挡住时仍然进行刷新
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final hitokoto = ref.watch(hitokotoProvider);

    return InkWell(
      onTap: () {
        hitokoto.whenData(
          (value) {
            try {
              launchUrlString(
                'https://hitokoto.cn/?uuid=${value.uuid}',
                mode: LaunchMode.externalApplication,
              );
            } catch (e) {
              App.printLog('launch hitokoto failed: $e');
            }
          },
        );
      },
      child: Tooltip(
        message: l10n.hiToKoToProvider,
        preferBelow: false,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          child: Text(
            hitokoto.when(
              data: (data) => data.hitokoto,
              error: (error, stackTrace) => l10n.hiToKoToFetching,
              loading: () => l10n.hiToKoToFetching,
            ),
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.outline,
            ),
            key: UniqueKey(),
          ),
        ),
      ),
    );
  }
}
