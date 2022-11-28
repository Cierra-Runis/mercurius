import 'package:mercurius/index.dart';

class LogModel extends ChangeNotifier {
  String logString = '';

  void addLog(String newLog) {
    logString += newLog;
  }

  void clearLog() {
    logString = '';
    notifyListeners();
    super.notifyListeners();
  }
}
