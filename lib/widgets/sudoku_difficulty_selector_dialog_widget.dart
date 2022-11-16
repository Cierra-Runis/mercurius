import 'package:mercurius/index.dart';

class SudokuDifficultySelectorDialogWidget extends StatefulWidget {
  const SudokuDifficultySelectorDialogWidget({super.key});

  @override
  State<SudokuDifficultySelectorDialogWidget> createState() =>
      _SudokuDifficultySelectorDialogWidgetState();
}

class _SudokuDifficultySelectorDialogWidgetState
    extends State<SudokuDifficultySelectorDialogWidget> {
  // 利用 difficultyIconMay 进行简化
  Map difficultyIconMay = {
    'beginner': Icons.child_friendly_rounded,
    'easy': Icons.child_care_rounded,
    'medium': Icons.school_rounded,
    'hard': Icons.biotech_rounded,
  };

  // 创建难度表
  List<ListTile> _createDifficultyList(BuildContext context) {
    List<ListTile> list =
        List<ListTile>.generate(0, (index) => const ListTile());
    // 遍历
    sudokuModel.difficultyMap.forEach(
      (key, value) {
        list.add(
          ListTile(
            leading: Icon(difficultyIconMay[key]),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(key),
                Text(
                  '空格数 $value',
                  style: TextStyle(
                    fontSize: 8,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.white54
                        : Colors.black54,
                  ),
                ),
              ],
            ),
            onTap: () {
              sudokuModel.changeDifficulty(key);
              // 直接退回至数独界面
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
        children: <Widget>[
          const Text('请选择难度'),
          Text(
            '请选择难度',
            style: TextStyle(
              fontSize: 10,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white54
                  : Colors.black54,
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
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('返回'),
        ),
      ],
    );
  }
}
