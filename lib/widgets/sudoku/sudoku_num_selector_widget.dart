import 'package:mercurius/index.dart';

class SudokuNumSelectorWidget extends StatefulWidget {
  /// 数独数字选择组件
  const SudokuNumSelectorWidget({
    Key? key,
    required this.row,
    required this.column,
  }) : super(key: key);

  final int row;
  final int column;

  @override
  State<SudokuNumSelectorWidget> createState() =>
      _SudokuNumSelectorWidgetState();
}

class _SudokuNumSelectorWidgetState extends State<SudokuNumSelectorWidget> {
  /// 创建一行按钮
  List<SizedBox> _createOneRowButton(int rowIndex) {
    List<SizedBox> buttonList = [];
    for (var columnIndex = 0; columnIndex < 3; columnIndex++) {
      buttonList.add(
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            key: Key('grid-button-$rowIndex-$columnIndex'),
            onPressed: () {
              mercuriusSudokuNotifier.changeSudoku(
                  widget.row, widget.column, 3 * rowIndex + columnIndex + 1);
              Navigator.of(context).pop();
              mercuriusSudokuNotifier.checkAnswer();
            },
            child: Text("${3 * rowIndex + columnIndex + 1}"),
          ),
        ),
      );
    }
    return buttonList;
  }

  /// 创建多行按钮
  List<Row> _createRows() {
    List<Row> row = [];
    for (var rowIndex = 0; rowIndex < 3; rowIndex++) {
      row.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _createOneRowButton(rowIndex),
        ),
      );
    }
    return row;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('请选择一位数字'),
          Text(
            '请选择一位数字',
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
          children: _createRows(),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: () {
            mercuriusSudokuNotifier.changeSudoku(widget.row, widget.column, 0);
            Navigator.of(context).pop();
          },
          child: const Text('清空'),
        ),
      ],
    );
  }
}
