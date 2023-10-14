import 'package:mercurius/index.dart';

class MercuriusEditingDiaryDialogWidget extends StatelessWidget {
  const MercuriusEditingDiaryDialogWidget({
    super.key,
    required this.editingDiaries,
  });

  final List<Diary> editingDiaries;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.continueEditingDiary),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: editingDiaries.length,
          itemBuilder: (context, index) => FrameSeparateWidget(
            index: index,
            placeHolder: const DiaryListItemPlaceHolderWidget(),
            child: DiaryListItemWidget(
              onTap: () => Navigator.pop(context, editingDiaries[index]),
              diary: editingDiaries[index],
            ),
          ),
        ),
      ),
    );
  }
}
