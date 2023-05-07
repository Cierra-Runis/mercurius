import 'package:mercurius/index.dart';

class DevLogDrawerWidget extends StatelessWidget {
  const DevLogDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: Consumer3<MercuriusProfileNotifier, MercuriusPositionNotifier,
            MercuriusPathNotifier>(
          builder: (
            context,
            mercuriusProfileNotifier,
            mercuriusPositionNotifier,
            mercuriusPathNotifier,
            child,
          ) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.25, sigmaY: 0.25),
              child: ListView(
                children: [
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
                  ListTile(
                    title: Text(
                      jsonEncode(mercuriusPathNotifier.path),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
