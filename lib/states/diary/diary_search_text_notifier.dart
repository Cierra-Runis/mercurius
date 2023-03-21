import 'package:mercurius/index.dart';

class DiarySearchTextNotifier extends ChangeNotifier {
  String contains = '\\n';

  void changeContains(String newContains) {
    contains = newContains == '' ? '\\n' : newContains;
    notifyListeners();
    super.notifyListeners();
  }
}
