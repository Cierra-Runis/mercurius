import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'diary_search_text.g.dart';

@riverpod
class DiarySearchText extends _$DiarySearchText {
  @override
  DiarySearch build() => const DiarySearch();

  void change([DiarySearch? newDiarySearch]) =>
      state = newDiarySearch ?? const DiarySearch();
}

@JsonSerializable()
class DiarySearch {
  const DiarySearch({
    this.text = '\\n',
    this.searchTitle = false,
  });
  final String text;
  final bool searchTitle;

  DiarySearch copyWith({
    String? text,
    bool? searchTitle,
  }) =>
      DiarySearch(
        text: text ?? this.text,
        searchTitle: searchTitle ?? this.searchTitle,
      );

  factory DiarySearch.fromJson(Map<String, dynamic> json) =>
      _$DiarySearchFromJson(json);
  Map<String, dynamic> toJson() => _$DiarySearchToJson(this);
}
