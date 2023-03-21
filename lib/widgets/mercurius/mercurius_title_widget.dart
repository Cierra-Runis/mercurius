import 'package:mercurius/index.dart';

class MercuriusTitleWidget extends StatelessWidget {
  const MercuriusTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MercuriusPositionNotifier>(
      builder: (context, mercuriusPositionNotifier, child) {
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
              onTap: () => mercuriusPositionNotifier.update(true),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    UniconsLine.location_arrow,
                    size: 6,
                  ),
                  Text(
                    " ${mercuriusPositionNotifier.cachePosition.latitude}N ${mercuriusPositionNotifier.cachePosition.longitude}E ",
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  Icon(
                    QWeatherIcon.getIconById(
                      int.parse(
                          mercuriusPositionNotifier.weatherBody.now!.icon!),
                    ),
                    size: 6,
                  ),
                ],
              ),
            ),
            Text(
              mercuriusPositionNotifier.cachePosition.city,
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
          ],
        );
      },
    );
  }
}
