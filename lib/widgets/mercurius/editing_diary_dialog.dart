import 'package:mercurius/index.dart';

class EditingDiaryDialog extends StatelessWidget {
  const EditingDiaryDialog({
    super.key,
    required this.editingDiaries,
  });

  final List<Diary> editingDiaries;

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return AlertDialog(
      title: Text(l10n.continueEditingDiary),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: editingDiaries.length,
          itemBuilder: (context, index) => FrameSeparateWidget(
            index: index,
            placeHolder: const DiaryListItemPlaceholder(),
            child: DiaryListItem(
              onTap: () => context.pop(editingDiaries[index]),
              diary: editingDiaries[index],
            ),
          ),
        ),
      ),
    );
  }
}
