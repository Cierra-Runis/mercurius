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
    @JsonKey(name: _Ext.accentColor) Color? accentColor,
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
      accentColor: _pers.getAccentColor(),
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

  Future<bool> setAccentColor(Color value) async {
    state = state.copyWith(accentColor: value);
    return _pers.setAccentColor(value);
  }
}
