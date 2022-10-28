import 'package:mercurius/index.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  void changeThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    notifyListeners();
  }
}
