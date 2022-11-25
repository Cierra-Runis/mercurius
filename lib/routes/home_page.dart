import 'package:mercurius/index.dart';
import 'package:mercurius/states/location_change_notifier.dart';
import 'package:mercurius/states/log_change_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(UniconsLine.user_circle),
          onPressed: () {},
        ),
        title: Column(
          children: [
            const Text(
              'Mercurius',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Saira',
              ),
            ),
            Consumer<LocationModel>(
              builder: (context, locationModel, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      UniconsLine.location_arrow,
                      size: 6,
                    ),
                    Text(
                      " ${(locationModel.position.latitude * 100).toInt() / 100}N ${(locationModel.position.longitude * 100).toInt() / 100}E ",
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                    const Icon(
                      UniconsLine.cloud,
                      size: 7,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_list_rounded),
          )
        ],
      ),
      body: Consumer4<ProfileModel, MercuriusWebModel, LocationModel, LogModel>(
        builder: (context, profileModel, mercuriusWebModel, locationModel,
            logModel, child) {
          return ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(
                  logModel.logString,
                  style: const TextStyle(
                    fontSize: 8,
                    fontFamily: 'Saira',
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
              const DiaryListCardWidget(),
              const DiaryListCardWidget(),
            ],
          );
        },
      ),
    );
  }
}
