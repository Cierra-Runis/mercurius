import 'package:mercurius/index.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Test',
    (WidgetTester tester) async {
      Profile profile = Profile.fromJson(jsonDecode(
          '{"user":null,"token":null,"themeMode":"system","cache":null,"lastLogin":null}'));
      profile.sudokuDifficulty ??= 'hard';
      DevTools.printLog(profile.toJson().toString());
    },
  );
}
