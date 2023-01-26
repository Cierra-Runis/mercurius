import 'package:mercurius/index.dart';

class MercuriusTitleWidget extends StatelessWidget {
  const MercuriusTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PositionModel>(
      builder: (context, positionModel, child) {
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
              onTap: () => positionModel.update(true),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    UniconsLine.location_arrow,
                    size: 6,
                  ),
                  Text(
                    " ${positionModel.cachePosition.latitude}N ${positionModel.cachePosition.longitude}E ",
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  Icon(
                    QWeatherIcon.getIconById(
                      int.parse(positionModel.weatherBody.now!.icon!),
                    ),
                    size: 6,
                  ),
                ],
              ),
            ),
            Text(
              positionModel.cachePosition.city,
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
