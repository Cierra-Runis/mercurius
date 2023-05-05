import 'package:mercurius/index.dart';

class DiaryListViewCardPlaceHolderWidget extends StatelessWidget {
  const DiaryListViewCardPlaceHolderWidget({
    required key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.outline.withOpacity(0.1);
    final highlightColor =
        Theme.of(context).colorScheme.outline.withOpacity(0.4);
    final dayWidget = MercuriusModifiedFadeShimmerWidget(
      width: 24,
      height: 20,
      radius: 6,
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
    final weatherWidget = MercuriusModifiedFadeShimmerWidget.round(
      size: 16,
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
    final weekdayWidget = MercuriusModifiedFadeShimmerWidget(
      width: 30,
      height: 10,
      radius: 5,
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
    final moodWidget = MercuriusModifiedFadeShimmerWidget.round(
      size: 16,
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
    final createDateTimeWidget = MercuriusModifiedFadeShimmerWidget(
      width: 72,
      height: 16,
      radius: 8,
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
    final latestEditTimeWidget = MercuriusModifiedFadeShimmerWidget(
      width: 32,
      height: 10,
      radius: 5,
      highlightColor: highlightColor,
      baseColor: baseColor,
    );
    final contentJsonStringWidget = MercuriusModifiedFadeShimmerWidget(
      width: 160,
      height: 12,
      radius: 6,
      highlightColor: highlightColor,
      baseColor: baseColor,
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
              Expanded(flex: 9, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
