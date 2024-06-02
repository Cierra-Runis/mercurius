import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

/// Add abstracts layer extension to [Persistence]
///
/// Naming the new keys, and provide default set/get methods
extension _GeneralSettingsExt on Persistence {
  static const themeMode = '${Persistence.prefix}_themeMode';
  ThemeMode getThemeMode() => ThemeMode.values.firstWhere(
        (e) => e.name == sp.getString(themeMode),
        orElse: () => ThemeMode.system,
      );

  Future<bool> setThemeMode(ThemeMode value) async =>
      await sp.setString(themeMode, value.name);

  static const bgImgPath = '${Persistence.prefix}_bgImgPath';
  String? getBgImgPath() => sp.getString(bgImgPath);

  Future<bool> setBgImgPath(String? value) async {
    if (value == null) return sp.remove(bgImgPath);
    return sp.setString(bgImgPath, value);
  }

  static const locale = '${Persistence.prefix}_locale';
  Locale? getLocale() {
    final value = sp.getString(locale);
    if (value == null) return null;
    final tags = value.split('-');
    return Locale.fromSubtags(
      languageCode: tags.first,
      scriptCode: tags.elementAtOrNull(1),
      countryCode: tags.elementAtOrNull(2),
    );
  }

  Future<bool> setLocale(Locale? value) async {
    if (value == null) return sp.remove(locale);
    return sp.setString(locale, value.toLanguageTag());
  }

  static const accentColor = '${Persistence.prefix}_accentColor';
  Color? getAccentColor() {
    final value = sp.getInt(accentColor);
    if (value == null) return null;
    return Color(value);
  }

  Future<bool> setAccentColor(Color? value) async {
    if (value == null) return sp.remove(accentColor);
    return sp.setInt(accentColor, value.value);
  }

  static const fontFamily = '${Persistence.prefix}_fontFamily';
  String? getFontFamily() => sp.getString(fontFamily);
  Future<bool> setFontFamily(String? value) async {
    if (value == null) return sp.remove(fontFamily);
    return sp.setString(fontFamily, value);
  }
}

/// Add abstracts layer extension to [Persistence]
///
/// Naming the new keys, and provide default set/get methods
extension _CloudSettingsExt on Persistence {
  static const autoUploadImages = '${Persistence.prefix}_autoUploadImages';
  bool getAutoUploadImages() => sp.getBool(autoUploadImages) ?? false;
  Future<bool> setAutoUploadImages(bool? value) async {
    if (value == null) return sp.remove(autoUploadImages);
    return sp.setBool(autoUploadImages, value);
  }

  static const autoBackupDiaries = '${Persistence.prefix}_autoBackupDiaries';
  bool getAutoBackupDiaries() => sp.getBool(autoBackupDiaries) ?? false;
  Future<bool> setAutoBackupDiaries(bool? value) async {
    if (value == null) return sp.remove(autoBackupDiaries);
    return sp.setBool(autoBackupDiaries, value);
  }

  static const gitHubOwner = '${Persistence.prefix}_gitHubOwner';
  String? getGitHubOwner() => sp.getString(gitHubOwner);
  Future<bool> setGitHubOwner(String? value) async {
    if (value == null) return sp.remove(gitHubOwner);
    return sp.setString(gitHubOwner, value);
  }

  static const gitHubRepo = '${Persistence.prefix}_gitHubRepo';
  String? getGitHubRepo() => sp.getString(gitHubRepo);
  Future<bool> setGitHubRepo(String? value) async {
    if (value == null) return sp.remove(gitHubRepo);
    return sp.setString(gitHubRepo, value);
  }

  static const gitHubToken = '${Persistence.prefix}_gitHubToken';
  String? getGitHubToken() => sp.getString(gitHubToken);
  Future<bool> setGitHubToken(String? value) async {
    if (value == null) return sp.remove(gitHubToken);
    return sp.setString(gitHubToken, value);
  }
}

extension _AndroidSettingsExt on Persistence {
  static const useAndroid13PhotoPicker =
      '${Persistence.prefix}_useAndroid13PhotoPicker';
  bool getUseAndroid13PhotoPicker() {
    final value = sp.getBool(useAndroid13PhotoPicker) ?? true;

    final imagePicker = ImagePickerPlatform.instance;
    if (imagePicker is ImagePickerAndroid) {
      imagePicker.useAndroidPhotoPicker = value;
    }
    return value;
  }

  Future<bool> setUseAndroid13PhotoPicker(bool? value) async {
    if (value == null) return sp.remove(useAndroid13PhotoPicker);

    final imagePicker = ImagePickerPlatform.instance;
    if (imagePicker is ImagePickerAndroid) {
      imagePicker.useAndroidPhotoPicker = value;
    }

    return sp.setBool(useAndroid13PhotoPicker, value);
  }
}

/// State which return by [ref.watch]
///
/// It contains [toString], [fromJson], [toJson], [copyWith] methods
@Freezed(toJson: false, fromJson: false)
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    @JsonKey(name: _GeneralSettingsExt.themeMode) required ThemeMode themeMode,
    @JsonKey(name: _GeneralSettingsExt.bgImgPath) String? bgImgPath,
    @JsonKey(name: _GeneralSettingsExt.locale) Locale? locale,
    @JsonKey(name: _GeneralSettingsExt.accentColor) Color? accentColor,
    @JsonKey(name: _GeneralSettingsExt.fontFamily) String? fontFamily,
    @JsonKey(name: _CloudSettingsExt.autoUploadImages)
    required bool autoUploadImages,
    @JsonKey(name: _CloudSettingsExt.autoBackupDiaries)
    required bool autoBackupDiaries,
    @JsonKey(name: _CloudSettingsExt.gitHubOwner) String? gitHubOwner,
    @JsonKey(name: _CloudSettingsExt.gitHubRepo) String? gitHubRepo,
    @JsonKey(name: _CloudSettingsExt.gitHubToken) String? gitHubToken,
    @JsonKey(name: _AndroidSettingsExt.useAndroid13PhotoPicker)
    required bool useAndroid13PhotoPicker,
  }) = _SettingsState;
}

/// State management
///
/// By watching [persistenceProvider],
/// its state reacts when [Persistence] change
@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  late final Persistence _pers;

  @override
  SettingsState build() {
    _pers = ref.watch(persistenceProvider);
    return SettingsState(
      themeMode: _pers.getThemeMode(),
      bgImgPath: _pers.getBgImgPath(),
      locale: _pers.getLocale(),
      accentColor: _pers.getAccentColor(),
      fontFamily: _pers.getFontFamily(),
      autoUploadImages: _pers.getAutoUploadImages(),
      autoBackupDiaries: _pers.getAutoBackupDiaries(),
      gitHubOwner: _pers.getGitHubOwner(),
      gitHubRepo: _pers.getGitHubRepo(),
      gitHubToken: _pers.getGitHubToken(),
      useAndroid13PhotoPicker: _pers.getUseAndroid13PhotoPicker(),
    );
  }

  Future<bool> setThemeMode(ThemeMode value) async {
    state = state.copyWith(themeMode: value);
    return _pers.setThemeMode(value);
  }

  Future<bool> loopThemeMode() async {
    final modes = App.themeModeIcon.keys.toList();
    final currentIndex = modes.indexOf(state.themeMode);
    final nextIndex = (currentIndex + 1) % modes.length;
    final nextMode = modes.elementAt(nextIndex);
    return setThemeMode(nextMode);
  }

  Future<bool> setBgImgPath(String? value) async {
    state = state.copyWith(bgImgPath: value);
    return _pers.setBgImgPath(value);
  }

  Future<bool> setLocale(Locale? value) async {
    state = state.copyWith(locale: value);
    return _pers.setLocale(value);
  }

  Future<bool> setAccentColor(Color? value) async {
    state = state.copyWith(accentColor: value);
    return _pers.setAccentColor(value);
  }

  Future<bool> setFontFamily(String? value) async {
    state = state.copyWith(fontFamily: value);
    return _pers.setFontFamily(value);
  }

  Future<bool> setAutoUploadImages(bool value) async {
    state = state.copyWith(autoUploadImages: value);
    return _pers.setAutoUploadImages(value);
  }

  Future<bool> setAutoBackupDiaries(bool value) async {
    state = state.copyWith(autoBackupDiaries: value);
    return _pers.setAutoBackupDiaries(value);
  }

  Future<bool> setGitHubOwner(String? value) async {
    state = state.copyWith(gitHubOwner: value);
    return _pers.setGitHubOwner(value);
  }

  Future<bool> setGitHubRepo(String? value) async {
    state = state.copyWith(gitHubRepo: value);
    return _pers.setGitHubRepo(value);
  }

  Future<bool> setGitHubToken(String? value) async {
    state = state.copyWith(gitHubToken: value);
    return _pers.setGitHubToken(value);
  }

  Future<bool> setUseAndroid13PhotoPicker(bool value) async {
    state = state.copyWith(useAndroid13PhotoPicker: value);
    return _pers.setUseAndroid13PhotoPicker(value);
  }
}
