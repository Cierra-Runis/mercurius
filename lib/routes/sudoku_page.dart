import 'package:mercurius/index.dart';

class SudokuPage extends StatefulWidget {
  const SudokuPage({super.key});

  @override
  State<SudokuPage> createState() => SudokuPageState();
}

class SudokuPageState extends State<SudokuPage> {
  late ConfettiController _confettiController;

  // 行列获取数独底色
  Color _buttonColor(BuildContext context, int rowIndex, int columnIndex) {
    Color color;
    if (([0, 1, 2].contains(rowIndex) && [3, 4, 5].contains(columnIndex)) ||
        ([3, 4, 5].contains(rowIndex) &&
            [0, 1, 2, 6, 7, 8].contains(columnIndex)) ||
        ([6, 7, 8].contains(rowIndex) && [3, 4, 5].contains(columnIndex))) {
      color = Theme.of(context).brightness == Brightness.dark
          ? Colors.black12
          : Colors.black54;
    } else {
      color = Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Colors.black12;
    }
    return color;
  }

  // 创建一行按钮
  List<SizedBox> _createOneRowButton(BuildContext context, int rowIndex) {
    List<SizedBox> buttonList =
        List<SizedBox>.generate(0, (index) => const SizedBox());
    for (var columnIndex = 0; columnIndex < 9; columnIndex++) {
      buttonList.add(
        SizedBox(
          height: 30,
          width: 30,
          child: TextButton(
            key: Key('grid-button-$rowIndex-$columnIndex'),
            onPressed: () =>
                sudokuModel.sudokuList[rowIndex][columnIndex] != 0 ||
                        sudokuModel.showedAnswer ||
                        sudokuModel.won
                    ? {}
                    : _selectSudokuNumDialog(context, rowIndex, columnIndex),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                _buttonColor(context, rowIndex, columnIndex),
              ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(
                  width: 0.4,
                  style: BorderStyle.solid,
                  color: Colors.black54,
                ),
              ),
            ),
            child: Text(
              sudokuModel.sudokuListCopy[rowIndex][columnIndex] == 0
                  ? ""
                  : sudokuModel.sudokuListCopy[rowIndex][columnIndex]
                      .toString(),
              style: sudokuModel.sudokuList[rowIndex][columnIndex] != 0
                  ? TextStyle(
                      color: (Theme.of(context).brightness == Brightness.dark)
                          ? Colors.white54
                          : Colors.black54,
                    )
                  : null,
            ),
          ),
        ),
      );
    }
    return buttonList;
  }

  // 创建多行按钮
  List<Row> _createRows(BuildContext context) {
    List<Row> rows = List<Row>.generate(0, (index) => Row());
    for (var rowIndex = 0; rowIndex < 9; rowIndex++) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _createOneRowButton(context, rowIndex),
        ),
      );
    }
    return rows;
  }

  @override
  void initState() {
    // 至数独界面再进行 sudokuModel 的初始化
    sudokuModel.init();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 1500));
    super.initState();
  }

  // 彩纸路径
  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    DevTools.printLog('[011] SudokuPage 构建中');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '彩蛋🎉️',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Consumer<SudokuModel>(
          builder: (context, sudokuModel, child) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _createRows(context),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: sudokuModel.won
                        ? (_confettiController..play())
                        : (_confettiController..stop()),
                    blastDirection: 0, // radial value - RIGHT
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    createParticlePath: drawStar,
                    emissionFrequency: 0.3,
                    minimumSize: const Size(10, 10),
                    maximumSize: const Size(50, 50),
                    numberOfParticles: 1,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: sudokuModel.won
                        ? (_confettiController..play())
                        : (_confettiController..stop()),
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    createParticlePath: drawStar,
                    emissionFrequency: 0.3,
                    minimumSize: const Size(10, 10),
                    maximumSize: const Size(50, 50),
                    numberOfParticles: 1,
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _optionMenu(context),
        mini: true,
        child: const Icon(Icons.menu_rounded),
      ),
    );
  }
}

Future<void> _selectSudokuNumDialog(
    BuildContext context, int rowIndex, int columnIndex) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return SudokuNumSelectorDialogWidget(row: rowIndex, column: columnIndex);
    },
  );
}

Future<void> _optionMenu(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 230,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.restart_alt_rounded),
              title: const Text('回到初始'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                sudokuModel.backToSudokuList();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('重开一局'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                sudokuModel.newSudoku();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_rounded),
              title: const Text('显示答案'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                sudokuModel.getAnswer();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.handyman_sharp),
              title: const Text('更改难度'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => _selectDifficultyDialog(context),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _selectDifficultyDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const SudokuDifficultySelectorDialogWidget();
    },
  );
}
