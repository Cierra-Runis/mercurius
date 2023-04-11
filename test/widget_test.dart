import 'package:mercurius/index.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Test',
    (WidgetTester tester) async {
      GithubLatestRelease githubLatestRelease = GithubLatestRelease.fromJson(
        jsonDecode(''),
      );
      MercuriusKit.printLog(githubLatestRelease.toJson().toString());
    },
  );
}
