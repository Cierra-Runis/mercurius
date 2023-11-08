import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'settings.g.dart';
part 'settings.freezed.dart';

/// Add abstracts layer extension to [Persistence]
///
/// Naming the new keys, and provide default set/get methods
extension _Ext on Persistence {
  static const themeMode = '${Persistence.prefix}_themeMode';
  static const bgImgPath = '${Persistence.prefix}_bgImgPath';

  ThemeMode getThemeMode() => ThemeMode.values.firstWhere(
        (element) => element.name == sp.getString(themeMode),
        orElse: () => ThemeMode.system,
      );
  Future<void> setThemeMode(ThemeMode value) async =>
      await sp.setString(themeMode, value.name);

  String? getBgImgPath() {
    final value = sp.getString(bgImgPath);
    if (value != null) {
      return value.isEmpty ? null : value;
    }
    return value;
  }

  Future<void> setBgImgPath(String? value) async =>
      await sp.setString(bgImgPath, value ?? '');
}

/// State which return by [ref.watch]
///
/// It contains [toString], [fromJson], [toJson], [copyWith] methods
@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    @JsonKey(name: _Ext.themeMode) required ThemeMode themeMode,
    @JsonKey(name: _Ext.bgImgPath) String? bgImgPath,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, Object?> json) =>
      _$SettingsStateFromJson(json);
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
    );
  }

  Future<void> setThemeMode(ThemeMode value) async {
    await _pers.setThemeMode(value);
    state = state.copyWith(themeMode: value);
  }

  Future<void> setBgImgPath(String? value) async {
    await _pers.setBgImgPath(value);
    state = state.copyWith(bgImgPath: value);
  }
}
