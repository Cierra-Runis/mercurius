
import 'package:mercurius/index.dart';

class MercuriusLogNotifier extends ChangeNotifier {
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
