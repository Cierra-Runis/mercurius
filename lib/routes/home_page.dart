import 'dart:convert';

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
        body: Consumer<ProfileModel>(
          builder: (context, profileModel, child) {
            return Center(
              child: Text(jsonEncode(profileModel.profile)),
            );
          },
        ),
      ),
    );
  }
}
