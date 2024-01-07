import 'package:mercurius/index.dart';

class FloatingDiaryButton extends ConsumerWidget {
  const FloatingDiaryButton({
    super.key,
  });

  Widget _getFloatingButton(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
    WidgetRef ref,
  ) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    final hasEditingDiary = snapshot.data != null && snapshot.data!.isNotEmpty;

    return Wrap(
      direction: Axis.vertical,
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        FutureBuilder<List<Diary>>(
          future: isarService.getDiaryByDate(DateTime.now().previousYear),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final diaries = snapshot.data!;

              return FloatingActionButton.small(
                heroTag: 'thisDayLastYear',
                tooltip: l10n.thisDayLastYear,
                onPressed: () => context.pushDialog(
                  AlertDialog(
                    title: Text(l10n.thisDayLastYear),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: diaries.length,
                        itemBuilder: (context, index) => FrameSeparateWidget(
                          index: index,
                          placeHolder: const DiaryListItemPlaceholder(),
                          child: DiaryListItem(
                            onTap: () => context.push(
                              DiaryPageItem(diary: diaries[index]),
                            ),
                            diary: diaries[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                child: const Icon(Icons.nights_stay_rounded),
              );
            }
            return const SizedBox();
          },
        ),
        FloatingActionButton(
          heroTag: 'create',
          tooltip:
              hasEditingDiary ? l10n.continueEditingDiary : l10n.createNewDiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: () => hasEditingDiary
              ? _editingDiary(context, ref, snapshot.data!)
              : _addDiary(context, ref),
          child: Badge(
            isLabelVisible: hasEditingDiary,
            child: const Icon(UniconsLine.diary),
          ),
        ),
      ],
    );
  }

  void _editingDiary(
    BuildContext context,
    WidgetRef ref,
    List<Diary> editingDiaries,
  ) async {
    final diary = await context.pushDialog<Diary?>(
      EditingDiaryDialog(
        editingDiaries: editingDiaries,
      ),
    );

    if (context.mounted && diary != null) {
      context.push(
        EditorPage(diary: diary, autoSave: true),
      );
    }
  }

  void _addDiary(BuildContext context, WidgetRef ref) async {
    final dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: DateTime.now(),
      firstDate: DateTime(1949, 10),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && dateTime != null) {
      final diary = Diary(
        id: Isar.autoIncrement,
        createDateTime: dateTime,
        latestEditTime: dateTime,
        contentJsonString: jsonEncode(Document().toDelta().toJson()),
        editing: true,
      );

      final id = await isarService.saveDiary(diary);
      isarService.deleteDiaryById(id);

      if (context.mounted) {
        context.push(
          EditorPage(
            diary: diary.copyWith(id: id),
            autoSave: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Diary>>(
      stream: isarService.listenToDiariesEditing().distinct(),
      builder: (context, snapshot) =>
          _getFloatingButton(context, snapshot, ref),
    );
  }
}
