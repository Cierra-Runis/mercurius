import 'dart:convert';

import 'package:mercurius/common/index.dart';

import 'index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text(jsonEncode(Global.profile.toJson())),
    );
  }
}
