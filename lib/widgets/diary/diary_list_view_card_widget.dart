import 'package:mercurius/index.dart';

class DiaryListViewCardWidget extends StatefulWidget {
  const DiaryListViewCardWidget({
    Key? key,
    this.diary,
    required this.context,
  }) : super(key: key);

  final Diary? diary;
  final BuildContext context;

  @override
  State<DiaryListViewCardWidget> createState() =>
      _DiaryListViewCardWidgetState();
}

class _DiaryListViewCardWidgetState extends State<DiaryListViewCardWidget> {
  late Diary? _diary;
  bool get _enable => widget.diary != null;

  late Color _baseColor;
  late Color _highLightColor;
  late Widget _dayWidget;
  late Widget _weatherWidget;
  late Widget _weekdayWidget;
  late Widget _moodWidget;
  late Widget _createDateTimeWidget;
  late Widget _latestEditTimeWidget;
  late Widget _contentJsonStringWidget;

  final Duration _duration = const Duration(milliseconds: 1200);

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;

    _baseColor = Theme.of(widget.context).colorScheme.outline.withOpacity(0.1);
    _highLightColor =
        Theme.of(widget.context).colorScheme.outline.withOpacity(0.4);
    _dayWidget = MercuriusModifiedFadeShimmerWidget(
      width: 24,
      height: 20,
      radius: 6,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );
    _weatherWidget = MercuriusModifiedFadeShimmerWidget.round(
      size: 16,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );
    _weekdayWidget = MercuriusModifiedFadeShimmerWidget(
      width: 30,
      height: 10,
      radius: 5,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );
    _moodWidget = MercuriusModifiedFadeShimmerWidget.round(
      size: 16,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );
    _createDateTimeWidget = MercuriusModifiedFadeShimmerWidget(
      width: 72,
      height: 16,
      radius: 8,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );
    _latestEditTimeWidget = MercuriusModifiedFadeShimmerWidget(
      width: 32,
      height: 10,
      radius: 5,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );
    _contentJsonStringWidget = MercuriusModifiedFadeShimmerWidget(
      width: 160,
      height: 12,
      radius: 6,
      highlightColor: _highLightColor,
      baseColor: _baseColor,
    );

    if (_enable) {
      _timer = Timer.periodic(
        _duration,
        (timer) {
          if (timer.tick > 0 && mounted) {
            setState(() {
              _dayWidget = Text(
                '${_diary!.createDateTime}'.substring(8, 10),
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'Saira',
                ),
              );
              _weekdayWidget = Text(
                DiaryConstance.weekdayMap[_diary!.createDateTime!.weekday]!,
                style: const TextStyle(
                  fontSize: 10,
                ),
              );
              _latestEditTimeWidget = Text(
                '${_diary!.latestEditTime}'.substring(11, 19),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              );
              _createDateTimeWidget = Text(
                _diary!.titleString ??
                    '${_diary!.createDateTime}'.substring(0, 10),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              );
              _contentJsonStringWidget = Text(
                Document.fromJson(
                  jsonDecode(_diary!.contentJsonString!),
                ).toPlainText().replaceAll(RegExp('\n'), ''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              );
              _moodWidget = Icon(
                size: 18,
                DiaryConstance.moodMap[_diary!.mood] ??
                    DiaryConstance.moodMap['开心'],
              );
              _weatherWidget = Icon(
                size: 18,
                QWeatherIcon.getIconDataById(
                  int.parse(_diary!.weather),
                ),
              );
            });
            _timer.cancel();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed:
          _enable ? (_) => isarService.deleteDiaryById(_diary!.id!) : null,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          bool? confirm = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return const MercuriusOriginalConfirmDialogWidget(
                itemName: '这篇日记',
              );
            },
          );
          return confirm == true;
        }
        return false;
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: _enable
              ? () async {
                  MercuriusKit.vibration();
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => DiaryPageViewWidget(
                      diary: _diary!,
                    ),
                  );
                }
              : null,
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
                    children: [
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _dayWidget,
                      ),
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _weekdayWidget,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 142,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _latestEditTimeWidget,
                      ),
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _createDateTimeWidget,
                      ),
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _contentJsonStringWidget,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _moodWidget,
                      ),
                      AnimatedSwitcher(
                        duration: _duration,
                        child: _weatherWidget,
                      )
                    ],
                  ),
                ),
                Expanded(flex: 9, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
