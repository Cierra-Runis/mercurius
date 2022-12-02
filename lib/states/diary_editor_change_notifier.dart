import 'package:mercurius/index.dart';

class DiaryEditorModel extends ChangeNotifier {
  late Diary diary;

  void init(Diary diary) {
    this.diary = diary;
  }

  void changeMood(String mood) {
    diary.mood = mood;
    notifyListeners();
    super.notifyListeners();
  }

  void saveDiary() {
    notifyListeners();
    super.notifyListeners();
  }
}
