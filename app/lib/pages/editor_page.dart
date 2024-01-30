import 'package:mercurius/index.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({
    super.key,
    required this.diary,
    this.autoSave = false,
  });

  final Diary diary;
  final bool autoSave;

  @override
  State<EditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends State<EditorPage> {
  late final QuillController _quillController;
  late final TextEditingController _titleController;

  final _scrollController = ScrollController();

  late Diary _diary;
  late bool _autoSave;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _autoSave = widget.autoSave;
    _quillController = QuillController(
      document: _diary.document,
      selection: const TextSelection.collapsed(offset: 0),
    );
    _titleController = TextEditingController(
      text: _diary.title,
    );
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  void _handleChangeDiary(Diary? newDiary) {
    setState(() => _diary = newDiary ?? _diary);
  }

  void _handleAutoSaveToggle(bool newState) {
    setState(() => _autoSave = newState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _EditorAppBar(
        diary: _diary,
        quillController: _quillController,
        titleController: _titleController,
        handleChangeDiary: _handleChangeDiary,
        handleAutoSaveToggle: _handleAutoSaveToggle,
        autoSave: _autoSave,
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
          const Divider(height: 0),
          _EditorToolbar(
            diary: _diary,
            controller: _quillController,
            scrollController: _scrollController,
            handleChangeDiary: _handleChangeDiary,
          ),
        ],
      ),
    );
  }
}

class _EditorAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _EditorAppBar({
    required this.diary,
    required this.quillController,
    required this.titleController,
    required this.handleChangeDiary,
    required this.handleAutoSaveToggle,
    this.autoSave = false,
  });

  final bool autoSave;

  final Diary diary;
  final QuillController quillController;
  final TextEditingController titleController;
  final ValueChanged<Diary?> handleChangeDiary;
  final ValueChanged<bool> handleAutoSaveToggle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return AppBar(
      title: TextField(
        textAlign: TextAlign.center,
        key: GlobalKey<FormState>(),
        controller: titleController,
        decoration: InputDecoration(
          hintText: l10n.untitled,
          border: InputBorder.none,
        ),
      ),
      actions: [
        _EditorAutoSaveButton(
          diary: diary,
          quillController: quillController,
          titleController: titleController,
          autoSave: autoSave,
          handleAutoSaveToggle: handleAutoSaveToggle,
        ),
        _EditorSaveButton(
          diary: diary,
          quillController: quillController,
          handleChangeDiary: handleChangeDiary,
          titleController: titleController,
        ),
      ],
    );
  }
}

class _EditorAutoSaveButton extends StatefulWidget {
  const _EditorAutoSaveButton({
    required this.diary,
    required this.quillController,
    required this.titleController,
    required this.handleAutoSaveToggle,
    this.autoSave = false,
  });

  final Diary diary;
  final bool autoSave;
  final QuillController quillController;
  final TextEditingController titleController;
  final ValueChanged<bool> handleAutoSaveToggle;

  @override
  State<_EditorAutoSaveButton> createState() => _EditorAutoSaveButtonState();
}

class _EditorAutoSaveButtonState extends State<_EditorAutoSaveButton> {
  late Diary _diary;
  late bool _autoSave;
  late QuillController _quillController;
  late TextEditingController _textEditingController;
  late ValueChanged<bool> _handleAutoSaveToggle;

  late PausableTimer _timer;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _autoSave = widget.autoSave;
    _quillController = widget.quillController;
    _textEditingController = widget.titleController;
    _handleAutoSaveToggle = widget.handleAutoSaveToggle;
    _timer = PausableTimer(const Duration(seconds: 5), () {
      _timer
        ..reset()
        ..start();
      final plainText = _quillController.document.toPlainText(
        EditorBody.embedBuilders,
        EditorBody.unknownEmbedBuilder,
      );
      if (plainText.isEmpty) return;
      final newDiary = _diary.copyWith(
        content: _quillController.document.toDelta().toJson(),
        editAt: DateTime.now(),
        title: _textEditingController.text,
        editing: true,
      );
      isarService.saveDiary(newDiary);
    });
    if (_autoSave) {
      _timer.start();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        thumbIcon: MaterialStateProperty.resolveWith<Icon>(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
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
}

class _EditorSaveButton extends ConsumerWidget {
  const _EditorSaveButton({
    required this.diary,
    required this.quillController,
    required this.handleChangeDiary,
    required this.titleController,
  });

  final Diary diary;
  final QuillController quillController;
  final ValueChanged<Diary?> handleChangeDiary;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return TextButton(
      onPressed: () {
        final plainText = quillController.document
            .toPlainText()
            .replaceAll(RegExp(r'\n'), '');
        if (plainText.isNotEmpty) {
          final newDiary = diary.copyWith(
            content: quillController.document.toDelta().toJson(),
            editAt: DateTime.now(),
            title: titleController.text,
            editing: false,
          );
          handleChangeDiary(newDiary);
          isarService.saveDiary(newDiary);
          return context.pop(newDiary);
        }

        App.vibration();
        Flushbar(
          icon: const Icon(UniconsLine.confused),
          isDismissible: false,
          messageText: Center(
            child: Text(
              l10n.contentCannotBeEmpty,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          margin: const EdgeInsets.fromLTRB(60, 16, 60, 0),
          barBlur: 1.0,
          borderRadius: BorderRadius.circular(16),
          backgroundColor: context.colorScheme.outline.withAlpha(16),
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
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(56, 56),
        ),
      ),
      child: Text(l10n.save),
    );
  }
}

class _EditorToolbar extends StatelessWidget {
  const _EditorToolbar({
    required this.diary,
    required this.controller,
    required this.scrollController,
    required this.handleChangeDiary,
  });

  final Diary diary;
  final QuillController controller;
  final ScrollController scrollController;
  final ValueChanged<Diary?> handleChangeDiary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
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
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.checked,
        ),

        /// TODO: Header
        // QuillToolbarSelectHeaderStyleDropdownButton(
        //   controller: controller,
        // ),
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
        _EditorImageButton(
          controller: controller,
        ),
        _EditorTagButton(
          controller: controller,
        ),
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
    );
  }

  void changMood(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryMoodType?>(
      _MoodSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(
      diary.copyWith(moodType: type ?? diary.moodType),
    );
  }

  void changeWeather(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryWeatherType>(
      _WeatherSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(
      diary.copyWith(weatherType: type ?? diary.weatherType),
    );
  }

  void changeDate(BuildContext context, Diary diary) async {
    final createAt = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: diary.createAt,
      firstDate: DateTime(1949, 10),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );
    handleChangeDiary(
      diary.copyWith(createAt: createAt ?? diary.createAt),
    );
  }
}

class _EditorImageButton extends ConsumerWidget {
  const _EditorImageButton({
    required this.controller,
  });

  final QuillController controller;

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);

    return IconButton(
      tooltip: l10n.insertImage,
      onPressed: () async {
        final l10n = context.l10n;

        final newImage = await ConfirmDialog(
          context: context,
          title: l10n.insertTheImageFrom,
          summary: '${l10n.imageGallery}？${l10n.systemFile}？',
          trueString: l10n.systemFile,
          falseString: l10n.imageGallery,
        ).confirm;

        if (newImage == null) return;

        if (newImage) {
          /// TIPS: 安卓启用新版本
          final imagePickerImplementation = ImagePickerPlatform.instance;
          if (imagePickerImplementation is ImagePickerAndroid) {
            imagePickerImplementation.useAndroidPhotoPicker = true;
          }

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
            final targetPath = join(paths.imageDirectory.path, pickedFile.name);
            await XFile(sourcePath).saveTo(targetPath);
            _insert(controller, pickedFile.name);
          }
        } else {
          if (context.mounted) {
            final image = await context.push<String?>(
              Scaffold(
                body: Gallery(
                  directory: paths.imageDirectory,
                  onCardTap: (context, filename) => context.pop(filename),
                ),
              ),
            );
            if (image != null) {
              _insert(controller, image);
            }
          }
        }
      },
      icon: const Icon(Icons.add_photo_alternate_rounded),
    );
  }
}

class _EditorTagButton extends StatelessWidget {
  const _EditorTagButton({
    required this.controller,
  });

  final QuillController controller;

  void _insert(
    QuillController controller,
    DiaryTag diaryTag,
  ) {
    controller.document.insert(
      controller.selection.extentOffset,
      TagBlockEmbed(json: diaryTag.toJson()),
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IconButton(
      tooltip: l10n.insertTag,
      onPressed: () async {
        final lang = Localizations.localeOf(context).toLanguageTag();
        final now = DateTime.now();
        final time = now.format(DateFormat.HOUR24_MINUTE_SECOND, lang);

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
}

class _TagSelector extends StatefulWidget {
  const _TagSelector({
    required this.defaultMessage,
  });

  final String defaultMessage;

  @override
  State<_TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<_TagSelector> {
  DiaryTagType _selectedType = DiaryTagType.values.first;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.defaultMessage);
  }

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
}

class _MoodSelector extends ConsumerWidget {
  const _MoodSelector({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              color: diary.moodType.name == moodType.name
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

class _WeatherSelector extends ConsumerWidget {
  const _WeatherSelector({
    required this.diary,
  });

  final Diary diary;

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
              color: diary.weatherType.weather == weatherType.weather
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
