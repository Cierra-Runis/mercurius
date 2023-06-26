import 'package:mercurius/index.dart';

class PlatformScrollBehavior extends CupertinoScrollBehavior {
  const PlatformScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      PointerDeviceKind.trackpad,
    };
  }
}
