import 'package:mercurius/index.dart';

const _day = BasedShimmer(width: 24, height: 20, radius: 6);
const _weather = BasedShimmer.round(size: 16);
const _weekday = BasedShimmer(width: 30, height: 10, radius: 5);
const _mood = BasedShimmer.round(size: 16);
const _belongTo = BasedShimmer(width: 72, height: 16, radius: 8);
const _editAt = BasedShimmer(width: 32, height: 10, radius: 5);
const _content = BasedShimmer(width: 160, height: 12, radius: 6);

class DiaryListItemPlaceholder extends StatelessWidget {
  const DiaryListItemPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerLow.withOpacity(0.8),
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: const SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 18, child: SizedBox()),
            Expanded(
              flex: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_day, _weekday],
              ),
            ),
            Expanded(
              flex: 142,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _editAt,
                  _belongTo,
                  _content,
                ],
              ),
            ),
            Expanded(
              flex: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_mood, _weather],
              ),
            ),
            Expanded(flex: 9, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
