import 'package:mercurius/index.dart';

class SudokuModel extends ChangeNotifier {
  late SudokuGenerator sudokuGenerator;
  late List<List<int>> sudokuList;
  late List<List<int>> sudokuListCopy;
  late List<List<int>> sudokuListAnswer;
  late String difficulty;
  late bool showedAnswer;
  late bool won;

  Map difficultyMap = {
    'beginner': 18,
    'easy': 27,
    'medium': 36,
    'hard': 54,
  };

  static List<List<int>> _copyGrid(List<List<int>> grid) {
    return grid.map((rowIndex) => [...rowIndex]).toList();
  }

  void init() {
    DevTools.printLog('[008] 数独初始化中');
    sudokuGenerator = SudokuGenerator(
        emptySquares: difficultyMap[profileModel.profile.sudokuDifficulty]);
    showedAnswer = false;
    won = false;
    sudokuList = sudokuGenerator.newSudoku;
    sudokuListCopy = _copyGrid(sudokuList);
    sudokuListAnswer = SudokuSolver.solve(sudokuList);
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
    sudokuListCopy = _copyGrid(sudokuListAnswer);
    showedAnswer = true;
    won = false;
    notifyListeners();
    super.notifyListeners();
  }

  void checkAnswer() {
    if (sudokuModel.sudokuListCopy.toString() ==
        sudokuModel.sudokuListAnswer.toString()) {
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
    difficulty = newDifficulty;
    profileModel
        .changeProfile(profileModel.profile..sudokuDifficulty = newDifficulty);
    newSudoku();
  }
}
