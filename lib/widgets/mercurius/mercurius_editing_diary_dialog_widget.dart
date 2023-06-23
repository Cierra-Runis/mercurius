import 'package:mercurius/index.dart';

class MercuriusEditingDiaryDialogWidget extends StatelessWidget {
  const MercuriusEditingDiaryDialogWidget({
    super.key,
    required this.editingDiaries,
  });

  final List<Diary> editingDiaries;

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return AlertDialog(
      title: Text(l10n.continueEditingDiary),
      content: SizedBox(
        width: double.maxFinite,
        child: DiaryListViewCardWidget(
          diary: editingDiaries[0],
          dismissDirection: DismissDirection.none,
          disabled: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, editingDiaries[0]),
          child: Text(l10n.confirm),
        )
      ],
    );
  }
}
