import 'package:mercurius/index.dart';

class Global {
  static late SharedPreferences _preferences;
  static Profile profile = Profile();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getString('profile') == null) {
      _preferences.setString(
          'profile', jsonEncode(Profile()..themeMode = ThemeMode.system));
      print('[01] ${jsonEncode(profile)}');
    }
    profile = Profile.fromJson(jsonDecode(_preferences.getString('profile')!));
    print('[02] ${jsonEncode(profile)}');
  }

  static Future<void> save() async {
    _preferences.setString('profile', jsonEncode(profile));
    print('[03] ${jsonEncode(profile)}');
  }
}
