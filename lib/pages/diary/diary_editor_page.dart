import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryEditorPage extends StatefulWidget {
  const DiaryEditorPage({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryEditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends State<DiaryEditorPage> {
  late final flutter_quill.QuillController _controller;
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  late Diary _currentDiary;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentDiary = widget.diary;
    });
    _controller = flutter_quill.QuillController(
      document: _currentDiary.contentJsonString != null
          ? flutter_quill.Document.fromJson(
              jsonDecode(_currentDiary.contentJsonString!),
            )
          : flutter_quill.Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _title.text = _currentDiary.titleString ?? '';
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  /// TIPS: 遮挡问题 https://github.com/singerdmx/flutter-quill/issues/1017
  /// TIPS: 选至末尾问题 https://github.com/singerdmx/flutter-quill/issues/1098
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            MercuriusKit.vibration();
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all<Size>(
              const Size(56, 56),
            ),
          ),
          child: const Text('取消'),
        ),
        title: TextField(
          textAlign: TextAlign.center,
          key: _formKey,
          controller: _title,
          decoration: const InputDecoration(
            hintText: '无标题',
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              String plainText = jsonEncode(
                _controller.document
                    .toPlainText()
                    .replaceAll(RegExp(r'\n'), '')
                    .replaceAll(RegExp(r' '), ''),
              );
              if (plainText != '""') {
                MercuriusKit.vibration();
                setState(() {
                  _currentDiary = Diary.copyFrom(
                    _currentDiary,
                    contentJsonString: jsonEncode(
                      _controller.document.toDelta().toJson(),
                    ),
                  );
                });
                isarService.saveDiary(
                  _currentDiary = Diary.copyFrom(
                    _currentDiary,
                    latestEditTime: DateTime.now(),
                    titleString: _title.text == '' ? null : _title.text,
                  ),
                );
                Navigator.of(context).pop(_currentDiary);
              } else {
                MercuriusKit.vibration(duration: 300);
                Flushbar(
                  icon: const Icon(UniconsLine.confused),
                  isDismissible: false,
                  messageText: const Center(
                    child: Text(
                      '内容不能为空',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(60, 16, 60, 0),
                  barBlur: 1.0,
                  borderRadius: BorderRadius.circular(16),
                  backgroundColor:
                      Theme.of(context).colorScheme.outline.withAlpha(16),
                  boxShadows: const [
                    BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 16),
                    ),
                  ],
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  flushbarPosition: FlushbarPosition.TOP,
                ).show(context);
              }
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(56, 56),
              ),
            ),
            child: const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: flutter_quill.QuillEditor(
                locale: const Locale('zh', 'CN'),
                focusNode: FocusNode(),
                scrollController: _scrollController,
                scrollable: true,
                expands: false,
                padding: const EdgeInsets.all(2.0),
                autoFocus: true,
                placeholder: '记些什么吧',
                controller: _controller,
                readOnly: false,
                onLaunchUrl: (url) {
                  launchUrlString(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                scrollBottomInset: 10,
                customStyles: flutter_quill.DefaultStyles(
                  placeHolder: flutter_quill.DefaultTextBlockStyle(
                    TextStyle(
                      fontFamily: 'Saira',
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    const flutter_quill.VerticalSpacing(0, 0),
                    const flutter_quill.VerticalSpacing(0, 0),
                    null,
                  ),
                  paragraph: flutter_quill.DefaultTextBlockStyle(
                    TextStyle(
                      fontFamily: 'Saira',
                      fontSize: 14,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    const flutter_quill.VerticalSpacing(0, 0),
                    const flutter_quill.VerticalSpacing(0, 0),
                    null,
                  ),
                ),
              ),
            ),
            const Divider(),
            flutter_quill.QuillToolbar.basic(
              controller: _controller,
              showUndo: false,
              showRedo: false,
              showFontFamily: false,
              showFontSize: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showColorButton: false,
              showCodeBlock: false,
              showInlineCode: false,
              showAlignmentButtons: true,
              showListBullets: false,
              showListCheck: false,
              showListNumbers: false,
              showJustifyAlignment: false,
              showDividers: false,
              showSmallButton: true,
              showSearchButton: false,
              showIndent: false,
              showLink: false,
              toolbarSectionSpacing: 4,
              iconTheme: flutter_quill.QuillIconTheme(
                borderRadius: 12,
                iconSelectedFillColor:
                    Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).colorScheme.outlineVariant
                        : Theme.of(context).colorScheme.primaryContainer,
              ),
              customButtons: [
                flutter_quill.QuillCustomButton(
                  icon: UniconsLine.clock,
                  onTap: () {
                    String dateTimeString =
                        '[${DateTime.now().format('y 年 M 月 d 日 EEEE HH:mm:ss', 'zh_CN')}]\n';
                    int end = _controller.selection.end;
                    _controller.document.insert(
                      end,
                      dateTimeString,
                    );
                    _controller.updateSelection(
                        TextSelection.collapsed(
                          offset: end + dateTimeString.length,
                        ),
                        flutter_quill.ChangeSource.LOCAL);
                  },
                ),
                flutter_quill.QuillCustomButton(
                  icon: Icons.mood,
                  onTap: () async {
                    Diary? newDiary = await _showDiaryMoodSelectorDialogWidget(
                        context, _currentDiary);
                    setState(() {
                      _currentDiary = newDiary ?? _currentDiary;
                    });
                  },
                ),
                flutter_quill.QuillCustomButton(
                  icon: Icons.cloud,
                  onTap: () async {
                    Diary? newDiary =
                        await _showDiaryWeatherSelectorDialogWidget(
                      context,
                      _currentDiary,
                    );
                    setState(() {
                      _currentDiary = newDiary ?? _currentDiary;
                    });
                  },
                ),
                flutter_quill.QuillCustomButton(
                  icon: Icons.date_range_rounded,
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1949, 10, 1),
                      lastDate: DateTime.now().add(
                        const Duration(days: 20000),
                      ),
                    );
                    if (dateTime != null) {
                      setState(() {
                        _currentDiary = Diary.copyFrom(
                          _currentDiary,
                          createDateTime: dateTime,
                        );
                      });
                    }
                  },
                ),
              ],
              locale: const Locale('zh', 'CN'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Diary?> _showDiaryMoodSelectorDialogWidget(
    BuildContext context,
    Diary diary,
  ) {
    return showDialog<Diary>(
      context: context,
      builder: (BuildContext context) {
        return _DiaryMoodSelectorDialogWidget(diary: diary);
      },
    );
  }

  Future<Diary?> _showDiaryWeatherSelectorDialogWidget(
    BuildContext context,
    Diary diary,
  ) {
    return showDialog<Diary>(
      context: context,
      builder: (BuildContext context) {
        return _DiaryWeatherSelectorDialogWidget(diary: diary);
      },
    );
  }
}

class _DiaryMoodSelectorDialogWidget extends StatefulWidget {
  /// 自定义组件
  const _DiaryMoodSelectorDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<_DiaryMoodSelectorDialogWidget> createState() =>
      _DiaryMoodSelectorDialogWidgetState();
}

class _DiaryMoodSelectorDialogWidgetState
    extends State<_DiaryMoodSelectorDialogWidget> {
  late Diary _currentDiary;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentDiary = widget.diary;
    });
  }

  List<Widget> _listAllMood() {
    List<Widget> buttonList = [];
    DiaryConstance.moodMap.forEach(
      (key, value) => buttonList.add(
        IconButton(
          onPressed: () => Navigator.of(context).pop(
            Diary.copyFrom(_currentDiary, mood: key),
          ),
          icon: Column(
            children: [Icon(value), Text(key)],
          ),
          color: _currentDiary.mood != key
              ? null
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('现在心情如何'),
          Text(
            'ねぇ、今どんな気持ち',
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
                children: _listAllMood(),
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

class _DiaryWeatherSelectorDialogWidget extends StatefulWidget {
  /// 自定义组件
  const _DiaryWeatherSelectorDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<_DiaryWeatherSelectorDialogWidget> createState() =>
      _DiaryWeatherSelectorDialogWidgetState();
}

class _DiaryWeatherSelectorDialogWidgetState
    extends State<_DiaryWeatherSelectorDialogWidget> {
  late Diary _currentDiary;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentDiary = widget.diary;
    });
  }

  List<Widget> _listAllWeather() {
    List<Widget> buttonList = [];
    DiaryConstance.weatherMap.forEach(
      (key, value) => buttonList.add(
        IconButton(
          onPressed: () => Navigator.of(context).pop(
            Diary.copyFrom(_currentDiary, weather: key),
          ),
          icon: Column(
            children: [
              Icon(value),
              Text(
                DiaryConstance.weatherCommitMap[key]!,
              ),
            ],
          ),
          color: _currentDiary.weather != key
              ? null
              : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
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
                children: _listAllWeather(),
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
