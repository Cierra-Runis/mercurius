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
        body: Consumer2<ThemeModel, UserModel>(
          builder: (context, themeModel, userModel, child) {
            return Center(
              child: Text(jsonEncode(userModel.user)),
            );
          },
        ),
      ),
    );
  }
}
