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

    return Wrap(
      direction: Axis.vertical,
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        FutureBuilder<List<Diary>>(
          future: isarService.getDiaryByDate(DateTime.now().previousYear),
          builder: (context, snapshot) {
            Mercurius.printLog(snapshot.data);

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Diary> diaries = snapshot.data!;

              return FloatingActionButton.small(
                tooltip: l10n.thisDayLastYear,
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.thisDayLastYear),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: diaries.length,
                        itemBuilder: (context, index) => FrameSeparateWidget(
                          index: index,
                          placeHolder: const DiaryListItemPlaceHolderWidget(),
                          child: DiaryListItemWidget(
                            onTap: () => Navigator.push(
                              context,
                              CupertinoDialogRoute(
                                builder: (context) => DiaryPageItemWidget(
                                  diary: diaries[index],
                                ),
                                context: context,
                              ),
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
        ),
      ],
    );
  }

  void _editingDiary(
    BuildContext context,
    WidgetRef ref,
    List<Diary> editingDiaries,
  ) async {
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
          builder: (context) => EditorPage(diary: diary, autoSave: true),
        ),
      );
    }
  }

  void _addDiary(BuildContext context, WidgetRef ref) async {
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

      int id = await isarService.saveDiary(diary);
      isarService.deleteDiaryById(id);

      if (context.mounted) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditorPage(
              diary: Diary.copyWith(diary, id: id),
              autoSave: true,
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
      builder: (context, snapshot) =>
          _getFloatingButton(context, snapshot, ref),
    );
  }
}
