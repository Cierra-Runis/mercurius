import 'package:mercurius/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer2<ProfileModel, MercuriusWebModel>(
          builder: (context, profileModel, mercuriusWebModel, child) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text(jsonEncode(profileModel.profile)),
                  ),
                  ListTile(
                    title: Text(jsonEncode(
                        mercuriusWebModel.githubLatestRelease.toJson())),
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
