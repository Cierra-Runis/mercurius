import 'package:mercurius/index.dart';

class MercuriusAppBarTitleWidget extends ConsumerWidget {
  const MercuriusAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(currentPositionProvider);

    return Column(
      children: [
        const Text(
          'Mercurius',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Saira',
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              UniconsLine.location_arrow,
              size: 6,
            ),
            Text(
              currentPosition.when(
                loading: () => ' ${CurrentPosition().humanFormat} ',
                error: (error, stackTrace) => 'error',
                data: (data) => ' ${data.humanFormat} ',
              ),
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
            Icon(
              QWeatherIcons.getIconWith(
                ref.watch(qWeatherNowProvider).when(
                      data: (data) => data.icon,
                      error: (error, stackTrace) =>
                          QWeatherIcons.tag_unknown_fill.tag,
                      loading: () => QWeatherIcons.tag_1031.tag,
                    ),
              ).iconData,
              size: 6,
            ),
          ],
        ),
        Text(
          currentPosition.when(
            loading: () => CurrentPosition().city,
            error: (error, stackTrace) => '获取中',
            data: (cachePosition) => cachePosition.city,
          ),
          style: const TextStyle(
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
