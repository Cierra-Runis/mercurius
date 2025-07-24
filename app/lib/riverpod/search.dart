import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search.freezed.dart';
part 'search.g.dart';

@Riverpod(keepAlive: true)
class Search extends _$Search {
  @override
  SearchState build() => const SearchState();

  void changeTo(SearchState search) => state = search;

  void clear() => state = state.copyWith(source: '');
}

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String source,
    @Default(false) bool multiLine,
    @Default(true) bool caseSensitive,
    @Default(false) bool unicode,
    @Default(false) bool dotAll,
  }) = _SearchState;

  const SearchState._();

  bool get isRegex => pattern is RegExp;

  /// Dart union type when?
  Pattern get pattern {
    try {
      return RegExp(
        source,
        multiLine: multiLine,
        caseSensitive: caseSensitive,
        unicode: unicode,
        dotAll: dotAll,
      );
    } on FormatException {
      return source;
    }
  }
}
