import 'package:mercurius/index.dart';

class MercuriusOriginalAppBarTitleWidget extends ConsumerWidget {
  const MercuriusOriginalAppBarTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusPosition = ref.watch(mercuriusPositionProvider);

    return Column(
      children: [
        const Text(
          'Mercurius',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Saira',
          ),
        ),
        InkWell(
          onTap: () =>
              ref.watch(mercuriusPositionProvider.notifier).refreshPosition(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                UniconsLine.location_arrow,
                size: 6,
              ),
              Text(
                mercuriusPosition.when(
                  loading: () =>
                      ' ${CachePosition().latitude}N ${CachePosition().longitude}E ',
                  error: (error, stackTrace) => '错误',
                  data: (cachePosition) =>
                      ' ${cachePosition.latitude}N ${cachePosition.longitude}E ',
                ),
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
              Icon(
                QWeatherIcon.getIconDataById(
                  int.parse(
                    /// TODO: weather
                    // cachePosition.weatherBody.now?.icon ??
                    '100',
                  ),
                ),
                size: 6,
              ),
            ],
          ),
        ),
        Text(
          mercuriusPosition.when(
            loading: () => CachePosition().city,
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
