import 'package:mercurius/index.dart';

class MercuriusScrollBehavior extends CupertinoScrollBehavior {
  const MercuriusScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      PointerDeviceKind.trackpad,
    };
  }
}
