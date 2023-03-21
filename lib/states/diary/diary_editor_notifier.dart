
import 'package:mercurius/index.dart';

class DiaryEditorNotifier extends ChangeNotifier {
  late Diary diary;

  void init(Diary diary) {
    this.diary = diary;
  }

  void changeMood(String mood) {
    diary.mood = mood;
    notifyListeners();
    super.notifyListeners();
  }

  void changeWeather(String weather) {
    diary.weather = weather;
    notifyListeners();
    super.notifyListeners();
  }

  void saveDiary() {
    notifyListeners();
    super.notifyListeners();
  }
}
