import 'package:mercurius/index.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProfileModel>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: () {
                if (profileModel.profile.user == null) {
                  _loginDialog(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                }
              },
            );
          },
        ),
        title: Consumer<LocationModel>(
          builder: (context, locationModel, child) {
            return Column(
              children: [
                const Text(
                  'Mercurius',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Saira',
                  ),
                ),
                InkWell(
                  onTap: () {
                    locationModel.refetchCurrentPosition(true);
                  },
                  child: Row(
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
                      Icon(
                        QWeatherIcon.getIconById(
                              int.parse(
                                locationModel.weatherBody.daily?[0].iconDay ??
                                    '2028',
                              ),
                            ) ??
                            QWeatherIcon.tag_weather_advisory,
                        size: 6,
                      ),
                    ],
                  ),
                ),
                Text(
                  locationModel.geoBody.location?[0].name ?? '',
                  style: const TextStyle(
                    fontSize: 8,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('设定'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ),
                  );
                },
              ),
              const Divider(
                height: 5,
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('关于'),
                onTap: () => _aboutDialog(context),
              ),
              const Divider(
                height: 5,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: HiToKoToWidget(),
          )
        ],
      ),
    );
  }

  Future<void> _aboutDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AboutDialogWidget();
      },
    );
  }

  Future<void> _loginDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginDialogWidget();
      },
    );
  }
}
