import 'package:mercurius/index.dart';

class MercuriusSudokuPage extends StatefulWidget {
  const MercuriusSudokuPage({super.key});

  @override
  State<MercuriusSudokuPage> createState() => MercuriusSudokuPageState();
}

class MercuriusSudokuPageState extends State<MercuriusSudokuPage> {
  late ConfettiController _confettiController;

  /// TODO: 完善计时器功能
  late Timer _timer;
  int _passed = 0;

  // late SudokuGenerator _sudokuGenerator;
  // late List<List<int>> _sudokuListAnswer;
  // late List<List<int>> _sudokuList;
  // late List<List<int>> _sudokuListCopy;
  // bool _showedAnswer = false;
  // bool _won = false;

  @override
  void initState() {
    super.initState();

    mercuriusSudokuNotifier.init();

    /// 彩纸
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );

    /// 计时器
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          _passed += 1;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /// 行列获取数独底色
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

  /// 创建一行按钮
  List<SizedBox> _createOneRowButton(BuildContext context, int rowIndex) {
    List<SizedBox> buttonList = [];
    for (var columnIndex = 0; columnIndex < 9; columnIndex++) {
      buttonList.add(
        SizedBox(
          height: 30,
          width: 30,
          child: TextButton(
            key: Key('grid-button-$rowIndex-$columnIndex'),
            onPressed: () => mercuriusSudokuNotifier.sudokuList[rowIndex]
                            [columnIndex] !=
                        0 ||
                    mercuriusSudokuNotifier.showedAnswer ||
                    mercuriusSudokuNotifier.won
                ? null
                : showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SudokuNumSelectorWidget(
                        row: rowIndex,
                        column: columnIndex,
                      );
                    },
                  ),
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
              mercuriusSudokuNotifier.sudokuListCopy[rowIndex][columnIndex] == 0
                  ? ''
                  : mercuriusSudokuNotifier.sudokuListCopy[rowIndex]
                          [columnIndex]
                      .toString(),
              style:
                  mercuriusSudokuNotifier.sudokuList[rowIndex][columnIndex] != 0
                      ? TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
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

  /// 创建多行按钮
  List<Row> _createRows(BuildContext context) {
    List<Row> rows = [];
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

  /// 彩纸路径
  Path _drawStar(Size size) {
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
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          '已经过 $_passed 秒',
                          key: ValueKey<int>(_passed),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _createRows(context),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: ConfettiWidget(
                confettiController: mercuriusSudokuNotifier.won
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
                createParticlePath: _drawStar,
                emissionFrequency: 0.3,
                minimumSize: const Size(10, 10),
                maximumSize: const Size(50, 50),
                numberOfParticles: 1,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: mercuriusSudokuNotifier.won
                    ? (_confettiController..play())
                    : (_confettiController..stop()),
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
                createParticlePath: _drawStar,
                emissionFrequency: 0.3,
                minimumSize: const Size(10, 10),
                maximumSize: const Size(50, 50),
                numberOfParticles: 1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showOptionMenu(context),
        mini: true,
        child: const Icon(Icons.menu_rounded),
      ),
    );
  }

  Future<void> _showOptionMenu(BuildContext context) {
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
                  mercuriusSudokuNotifier.backToSudokuList();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('重开一局'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  mercuriusSudokuNotifier.newSudoku();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.question_answer_rounded),
                title: const Text('显示答案'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  mercuriusSudokuNotifier.getAnswer();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.handyman_sharp),
                title: const Text('更改难度'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return const SudokuDifficultySelectorWidget();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
