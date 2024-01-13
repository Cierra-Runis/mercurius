import '../../app/lib/index.dart';

class PlatformScrollBehavior extends CupertinoScrollBehavior {
  const PlatformScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
