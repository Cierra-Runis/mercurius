import 'package:mercurius/index.dart';
part 'diary_search_text.g.dart';

@riverpod
class DiarySearchText extends _$DiarySearchText {
  @override
  String build() => '\\n';

  void change({String? newString}) {
    newString ??= '\\n';
    state = newString == '' ? '\\n' : newString;
  }
}
