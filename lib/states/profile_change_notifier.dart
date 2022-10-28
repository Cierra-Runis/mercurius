import 'package:mercurius/index.dart';

class ProfileModel extends ChangeNotifier {
  Profile profile = Profile()
    ..themeMode = ThemeMode.system
    ..cache = (CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100);

  void changeProfile(Profile profile) {
    this.profile = profile;
    notifyListeners();
  }
}
