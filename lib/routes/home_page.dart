import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mercurius/common/global.dart';

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
