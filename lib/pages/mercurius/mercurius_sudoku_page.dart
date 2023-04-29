import 'package:mercurius/index.dart';

class MercuriusSudokuPage extends StatefulWidget {
  const MercuriusSudokuPage({super.key});

  @override
  State<MercuriusSudokuPage> createState() => MercuriusSudokuPageState();
}

class MercuriusSudokuPageState extends State<MercuriusSudokuPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    mercuriusSudokuNotifier.init();

    /// 彩纸
    _confettiController = ConfettiController(
      duration: const Duration(milliseconds: 1500),
    );
  }

  /// 行列获取数独底色
  Color _buttonColor(BuildContext context, int rowIndex, int columnIndex) {
    int index = (rowIndex / 3).floor() + (columnIndex / 3).floor();

    Color color;
    if (index % 2 != 0) {
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
        child: Consumer<MercuriusSudokuNotifier>(
            builder: (context, mercuriusSudokuNotifier, child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Center(
                        child: SudokuTimerWidget(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                        ),
                        itemCount: 9 * 9,
                        itemBuilder: (context, index) {
                          int rowIndex = (index / 9).floor();
                          int columnIndex = index % 9;
                          return SizedBox(
                            height: 30,
                            width: 30,
                            child: TextButton(
                              key: Key('grid-button-$rowIndex-$columnIndex'),
                              onPressed: () {
                                mercuriusSudokuNotifier.sudokuList[rowIndex]
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
                                      );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  _buttonColor(context, rowIndex, columnIndex),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
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
                                mercuriusSudokuNotifier.sudokuListCopy[rowIndex]
                                            [columnIndex] ==
                                        0
                                    ? ''
                                    : '${mercuriusSudokuNotifier.sudokuListCopy[rowIndex][columnIndex]}',
                                style: mercuriusSudokuNotifier
                                                .sudokuList[rowIndex]
                                            [columnIndex] !=
                                        0
                                    ? TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white54
                                            : Colors.black54,
                                      )
                                    : null,
                              ),
                            ),
                          );
                        },
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
          );
        }),
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
