part of 'extension.dart';

extension IterableExt<E> on Iterable<E> {
  E? firstWhereOr(bool Function(E e) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
