import 'package:mercurius/index.dart';

class MercuriusSudokuNotifier extends ChangeNotifier {
  late SudokuGenerator _sudokuGenerator;
  late List<List<int>> _sudokuListAnswer;

  late List<List<int>> sudokuList;
  late List<List<int>> sudokuListCopy;
  late bool showedAnswer;
  late bool won;

  void init() {
    _sudokuGenerator = SudokuGenerator(
      emptySquares:
          mercuriusProfileNotifier.profile.sudokuDifficultyType!.emptySquares,
    );
    showedAnswer = false;
    won = false;
    sudokuList = _sudokuGenerator.newSudoku;
    sudokuListCopy = _copyGrid(sudokuList);
    _sudokuListAnswer = SudokuSolver.solve(sudokuList);
  }

  /// 深复制
  static List<List<int>> _copyGrid(List<List<int>> grid) {
    return grid.map((rowIndex) => [...rowIndex]).toList();
  }

  void changeSudoku(int rowIndex, int columnIndex, int value) {
    sudokuListCopy[rowIndex][columnIndex] = value;
    notifyListeners();
    super.notifyListeners();
  }

  void backToSudokuList() {
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
    if ('${mercuriusSudokuNotifier.sudokuListCopy}' ==
        '${mercuriusSudokuNotifier._sudokuListAnswer}') {
      won = true;
    } else {
      won = false;
    }
    notifyListeners();
    super.notifyListeners();
  }

  void changeDifficulty(SudokuDifficultyType newSudokuDifficultyType) {
    mercuriusProfileNotifier.changeProfile(
      mercuriusProfileNotifier.profile
        ..sudokuDifficultyType = newSudokuDifficultyType,
    );
    newSudoku();
  }
}
