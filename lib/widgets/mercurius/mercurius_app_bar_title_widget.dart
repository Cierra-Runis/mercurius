import 'package:mercurius/index.dart';

class MercuriusAppBarTitleWidget extends ConsumerWidget {
  const MercuriusAppBarTitleWidget({
    super.key,
    required this.controller,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(currentPositionProvider);

    return GestureDetector(
      onTap: () => controller.animateTo(
        0,
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut,
      ),
      onPanStart: (_) => windowManager.startDragging(),
      onDoubleTap: windowManager.center,
      child: Column(
        children: [
          const MercuriusAppNameWidget(),
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
              error: (error, stackTrace) => 'error',
              data: (cachePosition) => cachePosition.city,
            ),
            style: const TextStyle(
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
