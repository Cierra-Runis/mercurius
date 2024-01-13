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

  static const bgImgId = '${Persistence.prefix}_bgImgId';
  int? getBgImgId() => sp.getInt(bgImgId);

  Future<bool> setBgImgId(int? value) async {
    if (value == null) return sp.remove(bgImgId);
    return sp.setInt(bgImgId, value);
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
}

/// State which return by [ref.watch]
///
/// It contains [toString], [fromJson], [toJson], [copyWith] methods
@Freezed(toJson: false, fromJson: false)
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    @JsonKey(name: _Ext.themeMode) required ThemeMode themeMode,
    @JsonKey(name: _Ext.bgImgId) int? bgImgId,
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
      bgImgId: _pers.getBgImgId(),
      locale: _pers.getLocale(),
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

  Future<bool> setBgImgId(int? value) async {
    state = state.copyWith(bgImgId: value);
    return _pers.setBgImgId(value);
  }

  Future<bool> setLocale(Locale? value) async {
    state = state.copyWith(locale: value);
    return _pers.setLocale(value);
  }
}
