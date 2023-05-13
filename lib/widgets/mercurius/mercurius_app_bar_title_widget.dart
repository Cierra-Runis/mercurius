import 'package:mercurius/index.dart';

class MercuriusAppBarTitleWidget extends ConsumerWidget {
  const MercuriusAppBarTitleWidget({super.key});

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
          onTap: () {
            ref.watch(mercuriusPositionProvider.notifier).refreshPosition();
            return ref.refresh(qWeatherNowProvider);
          },
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
