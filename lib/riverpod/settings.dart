import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings.g.dart';
part 'settings.freezed.dart';

/// Add abstracts layer extension to [Persistence]
///
/// Naming the new keys, and provide default set/get methods
extension _Ext on Persistence {
  static const themeMode = '${Persistence.prefix}_themeMode';
  ThemeMode getThemeMode() => ThemeMode.values.firstWhere(
        (element) => element.name == sp.getString(themeMode),
        orElse: () => ThemeMode.system,
      );

  Future<void> setThemeMode(ThemeMode value) async =>
      await sp.setString(themeMode, value.name);

  static const bgImgPath = '${Persistence.prefix}_bgImgPath';
  String? getBgImgPath() {
    final value = sp.getString(bgImgPath);
    if (value != null) {
      return value.isEmpty ? null : value;
    }
    return value;
  }

  Future<void> setBgImgPath(String? value) async =>
      await sp.setString(bgImgPath, value ?? '');

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
}

/// State which return by [ref.watch]
///
/// It contains [toString], [fromJson], [toJson], [copyWith] methods
@Freezed(toJson: false, fromJson: false)
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    @JsonKey(name: _Ext.themeMode) required ThemeMode themeMode,
    @JsonKey(name: _Ext.bgImgPath) String? bgImgPath,
    @JsonKey(name: _Ext.locale) Locale? locale,
  }) = _SettingsState;
}

/// State management
///
/// By watching [persistenceProvider],
/// its state reacts when [Persistence] change
@riverpod
class Settings extends _$Settings {
  late final Persistence _pers;

  @override
  SettingsState build() {
    _pers = ref.watch(persistenceProvider);
    return SettingsState(
      themeMode: _pers.getThemeMode(),
      bgImgPath: _pers.getBgImgPath(),
      locale: _pers.getLocale(),
    );
  }

  static const themeModeIcon = {
    ThemeMode.system: Icons.brightness_auto_rounded,
    ThemeMode.light: Icons.light_mode_rounded,
    ThemeMode.dark: Icons.dark_mode_rounded,
  };

  Future<void> setThemeMode(ThemeMode value) async {
    await _pers.setThemeMode(value);
    state = state.copyWith(themeMode: value);
  }

  Future<void> loopThemeMode() async {
    final modes = themeModeIcon.keys.toList();
    final currentIndex = modes.indexOf(state.themeMode);
    final nextIndex = (currentIndex + 1) % modes.length;
    final nextMode = modes.elementAt(nextIndex);
    setThemeMode(nextMode);
  }

  Future<void> setBgImgPath(String? value) async {
    await _pers.setBgImgPath(value);
    state = state.copyWith(bgImgPath: value);
  }

  Future<bool> setLocale(Locale? value) async {
    state = state.copyWith(locale: value);
    return _pers.setLocale(value);
  }
}
