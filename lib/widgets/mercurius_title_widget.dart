import 'package:mercurius/index.dart';

class MercuriusTitleWidget extends StatefulWidget {
  const MercuriusTitleWidget({super.key});

  @override
  State<MercuriusTitleWidget> createState() => _MercuriusTitleWidgetState();
}

class _MercuriusTitleWidgetState extends State<MercuriusTitleWidget> {
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
              onTap: () {
                positionModel.update(true);
              },
              child: Tooltip(
                message: jsonEncode(positionModel.weatherBody),
                preferBelow: true,
                textStyle: TextStyle(
                  fontSize: 6,
                  color: Theme.of(context).brightness != Brightness.dark
                      ? Colors.white54
                      : Colors.black54,
                ),
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
