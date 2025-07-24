import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'persistence.g.dart';

@Riverpod(keepAlive: true)
Persistence persistence(Ref ref) =>
    throw Exception('$persistenceProvider not initialized');

/// This service abstracts the persistence layer.
class Persistence {
  static const prefix = 'ms';
  static const _spVersion = '${prefix}_spVersion';
  final SharedPreferences sp;

  const Persistence._(this.sp);

  static Future<Persistence> init() async {
    SharedPreferences pref;
    try {
      pref = await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception('Could not initialize SharedPreferences');
    }

    if (pref.getInt(_spVersion) == null) {
      await pref.setInt(_spVersion, 1);
    }

    return Persistence._(pref);
  }
}
