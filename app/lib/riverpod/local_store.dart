import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_store.freezed.dart';
part 'local_store.g.dart';

@Riverpod(keepAlive: true)
class LocalStore extends _$LocalStore {
  late final Persistence _pers;

  @override
  LocalStoreState build() {
    _pers = ref.watch(persistenceProvider);
    return LocalStoreState(
      jwt: _pers.getJWT(),
    );
  }

  Future<bool> setJWT(String? value) async {
    state = state.copyWith(jwt: value);
    return _pers.setJWT(value);
  }
}

@Freezed(toJson: false, fromJson: false)
class LocalStoreState with _$LocalStoreState {
  const factory LocalStoreState({
    @JsonKey(name: _LocalStoreExt.jwt) String? jwt,
  }) = _LocalStoreState;
}

extension _LocalStoreExt on Persistence {
  static const String jwt = 'jwt';
  String? getJWT() => sp.getString(jwt);
  Future<bool> setJWT(String? value) async {
    if (value == null) return sp.remove(jwt);
    return sp.setString(jwt, value);
  }
}
