import 'package:mercurius/index.dart';

class MercuriusFloatingDiaryButtonWidget extends ConsumerWidget {
  const MercuriusFloatingDiaryButtonWidget({
    super.key,
  });

  Widget _getFloatingButton(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
    WidgetRef ref,
  ) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    bool hasEditingDiary = snapshot.data != null && snapshot.data!.isNotEmpty;

    return FloatingActionButton(
      tooltip:
          hasEditingDiary ? l10n.continueEditingDiary : l10n.createNewDiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      onPressed: () => hasEditingDiary
          ? _editingDiary(context, ref, snapshot.data!)
          : _addDiary(context, ref),
      child: Badge(
        showBadge: hasEditingDiary,
        child: const Icon(UniconsLine.diary),
      ),
    );
  }

  void _editingDiary(
    BuildContext context,
    WidgetRef ref,
    List<Diary> editingDiaries,
  ) async {
    Mercurius.vibration(ref: ref);

    Diary? diary = await showDialog(
      context: context,
      builder: (context) => MercuriusEditingDiaryDialogWidget(
        editingDiaries: editingDiaries,
      ),
    );

    if (context.mounted && diary != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DiaryEditorPage(diary: diary),
        ),
      );
    }
  }

  void _addDiary(BuildContext context, WidgetRef ref) async {
    Mercurius.vibration(ref: ref);

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(1949, 10, 1),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && dateTime != null) {
      Diary diary = Diary(
        id: Isar.autoIncrement,
        createDateTime: dateTime,
        latestEditTime: dateTime,
        contentJsonString: jsonEncode(Document().toDelta().toJson()),
        editing: true,
      );

      /// TODO: 使用另一种方式获取可用的 id
      int id = await isarService.saveDiary(diary);
      isarService.deleteDiaryById(id);
      if (context.mounted) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => DiaryEditorPage(
              diary: Diary.copyWith(diary, id: id + 1),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Diary>>(
      stream: isarService.listenToDiariesEditing().distinct(),
      builder: (context, snapshot) {
        return _getFloatingButton(context, snapshot, ref);
      },
    );
  }
}
