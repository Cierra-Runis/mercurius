import 'package:mercurius/index.dart';

class MercuriusFloatingDiaryButtonWidget extends ConsumerWidget {
  const MercuriusFloatingDiaryButtonWidget({
    super.key,
  });

  void _floatingButtonOnPressed(BuildContext context, WidgetRef ref) async {
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
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DiaryEditorPage(
            diary: Diary(
              id: Isar.autoIncrement,
              createDateTime: dateTime,
              latestEditTime: dateTime,
              contentJsonString: jsonEncode(Document().toDelta().toJson()),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return FloatingActionButton(
      tooltip: l10n.createNewDiary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      onPressed: () => _floatingButtonOnPressed(context, ref),
      child: const Icon(UniconsLine.diary),
    );
  }
}
