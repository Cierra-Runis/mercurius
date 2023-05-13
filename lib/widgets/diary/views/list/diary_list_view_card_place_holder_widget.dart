import 'package:mercurius/index.dart';

class DiaryListViewCardPlaceHolderWidget extends StatelessWidget {
  const DiaryListViewCardPlaceHolderWidget({
    required key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const dayWidget = MercuriusFadeShimmerWidget(
      width: 24,
      height: 20,
      radius: 6,
    );
    const weatherWidget = MercuriusFadeShimmerWidget.round(
      size: 16,
    );
    const weekdayWidget = MercuriusFadeShimmerWidget(
      width: 30,
      height: 10,
      radius: 5,
    );
    const moodWidget = MercuriusFadeShimmerWidget.round(
      size: 16,
    );
    const createDateTimeWidget = MercuriusFadeShimmerWidget(
      width: 72,
      height: 16,
      radius: 8,
    );
    const latestEditTimeWidget = MercuriusFadeShimmerWidget(
      width: 32,
      height: 10,
      radius: 5,
    );
    const contentJsonStringWidget = MercuriusFadeShimmerWidget(
      width: 160,
      height: 12,
      radius: 6,
    );

    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 18, child: Container()),
              const Expanded(
                flex: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [dayWidget, weekdayWidget],
                ),
              ),
              const Expanded(
                flex: 142,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    latestEditTimeWidget,
                    createDateTimeWidget,
                    contentJsonStringWidget,
                  ],
                ),
              ),
              const Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [moodWidget, weatherWidget],
                ),
              ),
              Expanded(flex: 9, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
