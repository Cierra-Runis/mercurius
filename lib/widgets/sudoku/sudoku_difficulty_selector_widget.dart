import 'package:mercurius/index.dart';

class SudokuDifficultySelectorWidget extends StatefulWidget {
  const SudokuDifficultySelectorWidget({super.key});

  @override
  State<SudokuDifficultySelectorWidget> createState() =>
      _SudokuDifficultySelectorWidgetState();
}

class _SudokuDifficultySelectorWidgetState
    extends State<SudokuDifficultySelectorWidget> {
  /// 创建难度表
  List<ListTile> _createDifficultyList(BuildContext context) {
    List<ListTile> list = [];

    // 遍历
    for (var element in SudokuDifficultyType.values) {
      list.add(
        ListTile(
          leading: Icon(element.iconData),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(element.difficulty),
              Text(
                '空格数 ${element.emptySquares}',
                style: TextStyle(
                  fontSize: 8,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
          onTap: () {
            /// TODO: sudoku
            // mercuriusSudokuNotifier.changeDifficulty(element);
            // 直接退回至数独界面
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }
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
      content: SizedBox(
        width: double.minPositive,
        child: ListView(
          shrinkWrap: true,
          children: _createDifficultyList(context),
        ),
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
