import 'package:mercurius/index.dart';

class ProfileModel extends ChangeNotifier {
  static late SharedPreferences _preferences;
  Profile profile = Profile();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    print('[401]');
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getString('profile') == null) {
      _preferences.setString(
          'profile', jsonEncode(Profile()..themeMode = ThemeMode.system));
      print('[01] ${jsonEncode(profile)}');
    }
    profile = Profile.fromJson(jsonDecode(_preferences.getString('profile')!));
    print('[02] ${jsonEncode(profile)}');
  }

  void changeProfile(Profile profile) {
    print('[402]');
    this.profile = profile;
    save();
    notifyListeners();
  }

  void save() async {
    _preferences.setString('profile', jsonEncode(profile));
    print('[03] ${jsonEncode(profile)}');
  }
}
