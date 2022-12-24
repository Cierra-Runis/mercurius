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
        child:
            Consumer4<ProfileModel, MercuriusWebModel, LocationModel, LogModel>(
          builder: (
            context,
            profileModel,
            mercuriusWebModel,
            locationModel,
            logModel,
            child,
          ) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0.25, sigmaY: 0.25),
              child: ListView(
                children: [
                  InkWell(
                    onLongPress: () => logModel.clearLog(),
                    child: ListTile(
                      title: Text(
                        logModel.logString,
                        style: const TextStyle(
                          fontSize: 8,
                          fontFamily: 'Saira',
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(profileModel.profile),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(mercuriusWebModel.githubLatestRelease),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(locationModel.weatherBody.daily?[0].textDay),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(locationModel.weatherBody),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(locationModel.geoBody),
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      jsonEncode(locationModel.position),
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
