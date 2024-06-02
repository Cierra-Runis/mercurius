import 'package:mercurius/index.dart';

class HiToKoToWidget extends ConsumerWidget {
  const HiToKoToWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final hitokoto = ref.watch(hitokotoProvider);

    return InkWell(
      onTap: () => hitokoto.whenData(
        (value) => App.launchUrl('https://hitokoto.cn/?uuid=${value.uuid}'),
      ),
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
