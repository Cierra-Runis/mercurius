import 'package:mercurius/index.dart';

class DiaryWeatherSelectorDialogWidget extends StatelessWidget {
  const DiaryWeatherSelectorDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;
  List<Widget> _listAllWeather(BuildContext context) {
    List<Widget> buttonList = [];
    for (var element in DiaryWeatherType.values) {
      buttonList.add(
        IconButton(
          onPressed: () => Navigator.of(context).pop(
            Diary.copyWith(diary, weatherType: element),
          ),
          icon: Column(
            children: [
              Icon(element.qweatherIcons.iconData),
              Text(element.weather),
            ],
          ),
          color: diary.weatherType != element
              ? null
              : Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('现在天气如何'),
          Text(
            '今日もいい天気',
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Wrap(
                spacing: 16,
                direction: Axis.horizontal,
                children: _listAllWeather(context),
              ),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: () {
            MercuriusKit.vibration();
            Navigator.of(context).pop();
          },
          child: const Text('返回'),
        ),
      ],
    );
  }
}
