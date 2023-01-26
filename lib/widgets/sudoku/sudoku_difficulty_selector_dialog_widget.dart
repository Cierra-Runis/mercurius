import 'package:mercurius/index.dart';

class SudokuDifficultySelectorDialogWidget extends StatefulWidget {
  const SudokuDifficultySelectorDialogWidget({super.key});

  @override
  State<SudokuDifficultySelectorDialogWidget> createState() =>
      _SudokuDifficultySelectorDialogWidgetState();
}

class _SudokuDifficultySelectorDialogWidgetState
    extends State<SudokuDifficultySelectorDialogWidget> {
  /// 创建难度表
  List<ListTile> _createDifficultyList(BuildContext context) {
    List<ListTile> list = [];

    /// 遍历
    SudokuConstance.difficultyMap.forEach(
      (key, value) {
        list.add(
          ListTile(
            leading: Icon(SudokuConstance.difficultyIconMay[key]),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(key),
                Text(
                  '空格数 $value',
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            onTap: () {
              sudokuModel.changeDifficulty(key);

              /// 直接退回至数独界面
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请选择难度'),
          Text(
            '请选择难度',
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: _createDifficultyList(context),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('返回'),
        ),
      ],
    );
  }
}
