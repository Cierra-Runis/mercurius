import 'package:mercurius/index.dart';

class AppBarTitle extends ConsumerWidget {
  final ScrollController? controller;

  const AppBarTitle({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(currentPositionProvider);

    return GestureDetector(
      onTap: () => controller?.animateTo(
        -WindowAppBar.appBarHeight,
        duration: Durations.extralong4,
        curve: Curves.easeInOut,
      ),
      child: Column(
        children: [
          const AppName(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                UniconsLine.location_arrow,
                size: 6,
              ),
              Text(
                currentPosition.when(
                  loading: () => ' ${const CurrentPosition().humanFormat} ',
                  error: (error, stackTrace) => 'error',
                  data: (data) => ' ${data.humanFormat} ',
                ),
                style: const TextStyle(
                  fontSize: App.fontSize8,
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
              loading: () => const CurrentPosition().city,
              error: (error, stackTrace) => 'error',
              data: (data) => data.city,
            ),
            style: const TextStyle(
              fontSize: App.fontSize8,
            ),
          ),
        ],
      ),
    );
  }
}
