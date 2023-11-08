import 'package:mercurius/index.dart';

class DiaryListItemPlaceHolderWidget extends StatelessWidget {
  const DiaryListItemPlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const dayWidget = BasedShimmer(
      width: 24,
      height: 20,
      radius: 6,
    );
    const weatherWidget = BasedShimmer.round(
      size: 16,
    );
    const weekdayWidget = BasedShimmer(
      width: 30,
      height: 10,
      radius: 5,
    );
    const moodWidget = BasedShimmer.round(
      size: 16,
    );
    const createDateTimeWidget = BasedShimmer(
      width: 72,
      height: 16,
      radius: 8,
    );
    const latestEditTimeWidget = BasedShimmer(
      width: 32,
      height: 10,
      radius: 5,
    );
    const contentJsonStringWidget = BasedShimmer(
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
        child: const SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 18, child: SizedBox()),
              Expanded(
                flex: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [dayWidget, weekdayWidget],
                ),
              ),
              Expanded(
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
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [moodWidget, weatherWidget],
                ),
              ),
              Expanded(flex: 9, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
