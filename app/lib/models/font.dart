import 'package:mercurius/index.dart';

part 'font.freezed.dart';
part 'font.g.dart';

@freezed
class Font with _$Font {
  const factory Font({
    required String fontFamily,
    required Map<String, String> name,
    required List<String> files,
    required Map<String, String> description,
    required Uri website,
    required FontLicense license,
  }) = _Font;

  factory Font.fromJson(Json json) => _$FontFromJson(json);

  const Font._();

  String l10nDescription(String languageTag) =>
      description.entries.firstWhereOr((e) => e.key == languageTag)?.value ??
      description.entries.first.value;

  String l10nName(String languageTag) =>
      name.entries.firstWhereOr((e) => e.key == languageTag)?.value ??
      fontFamily;
}

@freezed
class FontLicense with _$FontLicense {
  const factory FontLicense({
    required String type,
    required Uri link,
  }) = _FontLicense;

  factory FontLicense.fromJson(Json json) => _$FontLicenseFromJson(json);
}
