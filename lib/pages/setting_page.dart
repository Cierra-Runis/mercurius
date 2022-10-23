import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

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
            onTap: () => _aboutUs(context),
          ),
        ],
      ),
    );
  }

  Future<void> _aboutUs(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Image(
                image: AssetImage('assets/icon/icon.png'),
                height: 50,
              ),
              Text('Mercurius'),
            ],
          ),
          content: const Text('114'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('返回'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
