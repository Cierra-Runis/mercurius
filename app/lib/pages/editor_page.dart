import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

class EditorPage extends StatefulWidget {
  final Diary diary;

  final bool autoSave;
  const EditorPage({
    super.key,
    required this.diary,
    this.autoSave = false,
  });

  @override
  State<EditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends State<EditorPage> {
  late final QuillController _quillController;

  final _scrollController = ScrollController();

  late Diary _diary;
  late bool _autoSave;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageTag = context.languageTag;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _diary.belongTo.format(
            DateFormat.YEAR_ABBR_MONTH_DAY,
            languageTag,
          ),
        ),
        actions: [
          _EditorAutoSaveButton(
            diary: _diary,
            quillController: _quillController,
            handleAutoSaveToggle: _handleAutoSaveToggle,
            autoSave: _autoSave,
          ),
          TextButton(
            onPressed: () {
              if (!_quillController.document.plainTextIsEmpty) {
                final newDiary = _diary.copyWith(
                  content: _quillController.document.toDelta().toJson(),
                  editAt: DateTimeExtension.today,
                  editing: false,
                );
                // isarService.saveDiary(newDiary);
                return context.pop(newDiary);
              }

              App.vibration();
              App.showSnackBar(Text(l10n.contentCannotBeEmpty));
            },
            child: Text(l10n.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: EditorBody(
              readOnly: false,
              controller: _quillController,
              scrollController: _scrollController,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _EditorToolbar(
              diary: _diary,
              controller: _quillController,
              handleChangeDiary: _handleChangeDiary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    _quillController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _autoSave = widget.autoSave;
    _quillController = QuillController(
      document: _diary.document,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  void _handleAutoSaveToggle(bool newState) {
    setState(() => _autoSave = newState);
  }

  void _handleChangeDiary(Diary? newDiary) {
    setState(() => _diary = newDiary ?? _diary);
  }
}

class _EditorAutoSaveButton extends StatefulWidget {
  final Diary diary;

  final bool autoSave;
  final QuillController quillController;
  final ValueChanged<bool> handleAutoSaveToggle;
  const _EditorAutoSaveButton({
    required this.diary,
    required this.quillController,
    required this.handleAutoSaveToggle,
    this.autoSave = false,
  });

  @override
  State<_EditorAutoSaveButton> createState() => _EditorAutoSaveButtonState();
}

class _EditorAutoSaveButtonState extends State<_EditorAutoSaveButton> {
  late Diary _diary;
  late bool _autoSave;
  late QuillController _quillController;
  late ValueChanged<bool> _handleAutoSaveToggle;

  late PausableTimer _timer;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        thumbIcon: WidgetStateProperty.resolveWith<Icon>(
          (Set<WidgetState> states) => states.contains(WidgetState.selected)
              ? const Icon(Icons.timer_rounded)
              : const Icon(Icons.timer_off_rounded),
        ),
        value: _autoSave,
        onChanged: (value) {
          setState(() => (_autoSave = value) ? _timer.start() : _timer.pause());
          _handleAutoSaveToggle(value);
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _autoSave = widget.autoSave;
    _quillController = widget.quillController;
    _handleAutoSaveToggle = widget.handleAutoSaveToggle;
    _timer = PausableTimer(const Duration(seconds: 5), () {
      _timer
        ..reset()
        ..start();

      if (_quillController.document.plainTextIsEmpty) return;

      final newDiary = _diary.copyWith(
        content: _quillController.document.toDelta().toJson(),
        editAt: DateTimeExtension.today,
        editing: true,
      );
      // isarService.saveDiary(newDiary);
    });
    if (_autoSave) {
      _timer.start();
    }
  }
}

class _EditorImageButton extends ConsumerWidget {
  final QuillController controller;

  const _EditorImageButton({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final imageDirectory = ref.watch(
      pathsProvider.select((value) => value.image),
    );

    return IconButton(
      tooltip: l10n.insertImage,
      onPressed: () async {
        final l10n = context.l10n;

        final newImage = await ConfirmDialog(
          context: context,
          title: l10n.insertTheImageFrom,
          summary: '${l10n.imageGallery}？${l10n.systemFile}？',
          confirmString: l10n.systemFile,
          denyString: l10n.imageGallery,
        ).confirm;

        if (!context.mounted) return;

        return switch (newImage) {
          ConfirmResult.deny => _insertFromGallery(context, imageDirectory),
          ConfirmResult.confirm => _insertFromSystem(imageDirectory),
          _ => null
        };
      },
      icon: const Icon(Icons.add_photo_alternate_rounded),
    );
  }

  void _insert(QuillController controller, String filename) {
    controller.document.insert(controller.selection.extentOffset, '\n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(
      controller.selection.extentOffset,
      ImageBlockEmbed(filename: filename),
    );

    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, ' ');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, '\n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );
  }

  void _insertFromGallery(
    BuildContext context,
    Directory imageDirectory,
  ) async {
    final l10n = context.l10n;
    final selectedFilename = await context.push<String?>(
      Scaffold(
        appBar: AppBar(
          title: Text(l10n.imageGallery),
        ),
        body: Gallery(
          directory: imageDirectory,
          onCardTap: (context, filename) => context.pop(filename),
        ),
      ),
    );
    if (selectedFilename != null) {
      _insert(controller, selectedFilename);
    }
  }

  void _insertFromSystem(Directory imageDirectory) async {
    /// TIPS: 这里返还的是图片地址
    /// TIPS: 缓存于 `/data/user/0/pers.cierra_runis.mercurius/cache/` 下
    /// TIPS: 而不是可见于 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/cache/` 下
    /// TIPS: 这会导致用户清除缓存后图片无法加载的问题
    /// TIPS: 故修改图片地址至 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/image/` 下
    /// TIPS: 并删除所需的中间缓存图片

    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final sourcePath = pickedFile.path;
      final targetPath = p.join(imageDirectory.path, pickedFile.name);
      await XFile(sourcePath).saveTo(targetPath);
      _insert(controller, pickedFile.name);
    }
  }
}

class _EditorTagButton extends StatelessWidget {
  final QuillController controller;

  const _EditorTagButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IconButton(
      tooltip: l10n.insertTag,
      onPressed: () async {
        final lang = Localizations.localeOf(context).toLanguageTag();
        final time = DateTimeExtension.today
            .format(DateFormat.HOUR24_MINUTE_SECOND, lang);

        final diaryTag = await showDialog<DiaryTag>(
          context: context,
          builder: (context) => _TagSelector(
            defaultMessage: time,
          ),
        );
        if (diaryTag != null) _insert(controller, diaryTag);
      },
      icon: const Icon(Icons.new_label_rounded),
    );
  }

  void _insert(
    QuillController controller,
    DiaryTag diaryTag,
  ) {
    controller.document.insert(
      controller.selection.extentOffset,
      diaryTag.toEmbeddable(),
    );

    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, ' \n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 2,
      ),
      ChangeSource.local,
    );
  }
}

class _EditorToolbar extends StatelessWidget {
  final Diary diary;

  final QuillController controller;
  final ValueChanged<Diary?> handleChangeDiary;
  const _EditorToolbar({
    required this.diary,
    required this.controller,
    required this.handleChangeDiary,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Row(
        children: [
          QuillToolbarHistoryButton(controller: controller, isUndo: true),
          QuillToolbarHistoryButton(controller: controller, isUndo: false),

          const SizedBox(height: 18, child: VerticalDivider()),

          QuillToolbarSelectHeaderStyleDropdownButton(
            controller: controller,
          ),

          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.bold,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.italic,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.underline,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.strikeThrough,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.small,
          ),

          const SizedBox(height: 18, child: VerticalDivider()),

          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.leftAlignment,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.centerAlignment,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.rightAlignment,
          ),

          /// TODO: CheckList
          QuillToolbarToggleCheckListButton(
            controller: controller,
          ),

          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.ol,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.ul,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.codeBlock,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.blockQuote,
          ),

          const SizedBox(height: 18, child: VerticalDivider()),

          _EditorImageButton(
            controller: controller,
          ),
          _EditorTagButton(
            controller: controller,
          ),

          const SizedBox(height: 18, child: VerticalDivider()),

          IconButton(
            tooltip: l10n.changeMood,
            onPressed: () => changMood(context, diary),
            icon: const Icon(Icons.mood_rounded),
          ),
          IconButton(
            tooltip: l10n.changeWeather,
            onPressed: () => changeWeather(context, diary),
            icon: const Icon(Icons.cloud_rounded),
          ),
          IconButton(
            tooltip: l10n.changeDate,
            onPressed: () => changeDate(context, diary),
            icon: const Icon(Icons.calendar_month_rounded),
          ),
        ]
            .map(
              (e) => Transform.scale(
                scale: 0.8,
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }

  void changeDate(BuildContext context, Diary diary) async {
    final belongTo = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: diary.belongTo,
      firstDate: DateTime(1949, 10),
      lastDate: DateTimeExtension.today.add(
        const Duration(days: 20000),
      ),
    );
    handleChangeDiary(
      diary.copyWith(belongTo: belongTo ?? diary.belongTo),
    );
  }

  void changeWeather(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryWeatherType>(
      _WeatherSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(
      diary.copyWith(weatherType: type),
    );
  }

  void changMood(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryMoodType?>(
      _MoodSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(
      diary.copyWith(moodType: type),
    );
  }
}

class _MoodSelector extends StatelessWidget {
  final Diary diary;

  const _MoodSelector({required this.diary});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.howIsYourMoodNow),
          Text(
            l10n.howIsYourMoodNowDescription,
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: DiaryMoodType.values.length,
          itemBuilder: (context, index) {
            final moodType = DiaryMoodType.values[index];
            return IconButton(
              tooltip: l10n.moodText(moodType.mood),
              onPressed: () => context.pop(moodType),
              icon: Icon(moodType.iconData),
              color: diary.moodType?.name == moodType.name
                  ? context.colorScheme.primary
                  : null,
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(l10n.back),
        ),
      ],
    );
  }
}

class _TagSelector extends StatefulWidget {
  final String defaultMessage;

  const _TagSelector({required this.defaultMessage});

  @override
  State<_TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<_TagSelector> {
  DiaryTagType _selectedType = DiaryTagType.values.first;
  late final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.insertTagTitle),
      content: BasedListView(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 64,
            ),
            itemCount: DiaryTagType.values.length,
            itemBuilder: (context, index) {
              final tagType = DiaryTagType.values[index];
              return IconButton(
                onPressed: () => setState(() {
                  _selectedType = tagType;
                }),
                icon: Icon(tagType.iconData),
                color: _selectedType != tagType
                    ? null
                    : context.colorScheme.primary,
              );
            },
          ),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: l10n.insertTagMessage,
            ),
          ),
        ],
      ).adaptAlertDialog,
      actions: [
        TextButton(
          onPressed: () => context.pop(
            DiaryTag(
              tagType: _selectedType,
              message: _textEditingController.text,
            ),
          ),
          child: Text(l10n.confirm),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.defaultMessage);
  }
}

class _WeatherSelector extends ConsumerWidget {
  final Diary diary;

  const _WeatherSelector({required this.diary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.whatIsTheWeatherNow),
          Text(
            l10n.whatIsTheWeatherNowDescription,
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: DiaryWeatherType.values.length,
          itemBuilder: (context, index) {
            final weatherType = DiaryWeatherType.values[index];
            return IconButton(
              tooltip: l10n.weatherText(weatherType.weather),
              color: diary.weatherType?.weather == weatherType.weather
                  ? context.colorScheme.primary
                  : null,
              onPressed: () => context.pop(weatherType),
              icon: Icon(weatherType.qweatherIcons.iconData),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(l10n.back),
        ),
      ],
    );
  }
}
