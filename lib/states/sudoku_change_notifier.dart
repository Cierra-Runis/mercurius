import 'package:mercurius/index.dart';

class SudokuModel extends ChangeNotifier {
  late SudokuGenerator _sudokuGenerator;
  late List<List<int>> _sudokuListAnswer;

  late List<List<int>> sudokuList;
  late List<List<int>> sudokuListCopy;
  late bool showedAnswer;
  late bool won;

  /// 深复制
  static List<List<int>> _copyGrid(List<List<int>> grid) {
    return grid.map((rowIndex) => [...rowIndex]).toList();
  }

  void init() {
    DevTools.printLog('[008] 数独初始化中');
    _sudokuGenerator = SudokuGenerator(
      emptySquares:
          SudokuConstance.difficultyMap[profileModel.profile.sudokuDifficulty],
    );
    showedAnswer = false;
    won = false;
    sudokuList = _sudokuGenerator.newSudoku;
    sudokuListCopy = _copyGrid(sudokuList);
    _sudokuListAnswer = SudokuSolver.solve(sudokuList);
  }

  void changeSudoku(int rowIndex, int columnIndex, int value) {
    DevTools.printLog(
        '[009] sudokuListCopy[$rowIndex,$columnIndex] 变更为 $value');
    sudokuListCopy[rowIndex][columnIndex] = value;
    notifyListeners();
    super.notifyListeners();
  }

  void backToSudokuList() {
    DevTools.printLog('[010] sudokuListCopy 重回');
    sudokuListCopy = _copyGrid(sudokuList);
    showedAnswer = false;
    won = false;
    notifyListeners();
    super.notifyListeners();
  }

  void newSudoku() {
    init();
    notifyListeners();
    super.notifyListeners();
  }

  void getAnswer() {
    sudokuListCopy = _copyGrid(_sudokuListAnswer);
    showedAnswer = true;
    won = false;
    notifyListeners();
    super.notifyListeners();
  }

  void checkAnswer() {
    if (sudokuModel.sudokuListCopy.toString() ==
        sudokuModel._sudokuListAnswer.toString()) {
      DevTools.printLog("Game Over");
      won = true;
    } else {
      DevTools.printLog("Game Keeping");
      won = false;
    }
    notifyListeners();
    super.notifyListeners();
  }

  void changeDifficulty(String newDifficulty) {
    profileModel
        .changeProfile(profileModel.profile..sudokuDifficulty = newDifficulty);
    newSudoku();
  }
}
