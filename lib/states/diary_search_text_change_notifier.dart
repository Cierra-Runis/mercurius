import 'package:mercurius/index.dart';

class DiarySearchTextModel extends ChangeNotifier {
  String contains = '\\n';

  void changeContains(String newContains) {
    contains = newContains == '' ? '\\n' : newContains;
    notifyListeners();
    super.notifyListeners();
  }
}
