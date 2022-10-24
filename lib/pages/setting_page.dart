import 'package:flutter/material.dart';
import 'package:mercurius/widgets/about.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const ListTile(
            title: Text('ListTile with red background'),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('关于'),
            onTap: () => _about(context),
          ),
        ],
      ),
    );
  }

  Future<void> _about(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const About();
      },
    );
  }
}
