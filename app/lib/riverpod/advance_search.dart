import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'advance_search.g.dart';
part 'advance_search.freezed.dart';

@freezed
class AdvanceSearchState with _$AdvanceSearchState {
  const AdvanceSearchState._();

  const factory AdvanceSearchState({
    @Default('') String source,
    @Default(false) bool multiLine,
    @Default(true) bool caseSensitive,
    @Default(false) bool unicode,
    @Default(false) bool dotAll,
  }) = _AdvanceSearchState;

  bool get isRegex => pattern is RegExp;

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

typedef TransformFunction = AdvanceSearchState Function(
  AdvanceSearchState state,
);

@riverpod
class AdvanceSearch extends _$AdvanceSearch {
  @override
  AdvanceSearchState build() => const AdvanceSearchState();

  void clear() => changeTo((state) => state.copyWith(source: ''));

  void changeTo(TransformFunction transform) => state = transform(state);
}
