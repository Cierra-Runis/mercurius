
import 'package:mercurius/index.dart';

import 'dart:ui';

class DevLogDrawerWidget extends StatefulWidget {
  const DevLogDrawerWidget({super.key});

  @override
  State<DevLogDrawerWidget> createState() => _DevLogDrawerWidgetState();
}

class _DevLogDrawerWidgetState extends State<DevLogDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Consumer4<MercuriusProfileNotifier, MercuriusWebNotifier,
            MercuriusPositionNotifier, MercuriusLogNotifier>(
          builder: (
            context,
            mercuriusProfileNotifier,
            mercuriusWebNotifier,
            mercuriusPositionNotifier,
            mercuriusLogNotifier,
            child,
          ) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.25, sigmaY: 0.25),
              child: ListView(
                children: [
                  InkWell(
                    onLongPress: () => mercuriusLogNotifier.clearLog(),
                    child: ListTile(
                      title: Text(
                        mercuriusLogNotifier.logString,
                        style: const TextStyle(
                          fontSize: 8,
                          fontFamily: 'Saira',
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(mercuriusProfileNotifier.profile),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(mercuriusWebNotifier.githubLatestRelease),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(mercuriusPositionNotifier.weatherBody),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(mercuriusPositionNotifier.cachePosition),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
