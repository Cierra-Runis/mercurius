// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercurius/index.dart';

import 'package:mercurius/widgets/index.dart';
import 'package:mercurius/routes/index.dart';

Future<HiToKoTo> fetchHiToKoTo() async {
  final response = await http.get(Uri.parse('https://v1.hitokoto.cn/'));

  if (response.statusCode == 200) {
    return HiToKoTo.fromJson(jsonDecode(response.body));
  } else {
    return HiToKoTo.fromJson(jsonDecode(
        '{"id":8035,"uuid":"d4ea5c57-bd64-4b9c-81a1-3035bc059b43","hitokoto":"没有BUG的代码是不完美的！","type":"l","from":"Sodium_Sulfate","from_who":"Sodium_Sulfate","creator":"Sodium_Sulfate","creator_uid":12666,"reviewer":1,"commit_from":"web","created_at":"1658485841","length":14}'));
  }
}

class HiToKoTo {
  final int id;
  final String uuid;
  final String hitokoto;
  final String type;
  final String from;
  final String from_who;
  final String creator;
  final int creator_uid;
  final int reviewer;
  final String commit_from;
  final String created_at;
  final int length;

  const HiToKoTo({
    required this.id,
    required this.uuid,
    required this.hitokoto,
    required this.type,
    required this.from,
    required this.from_who,
    required this.creator,
    required this.creator_uid,
    required this.reviewer,
    required this.commit_from,
    required this.created_at,
    required this.length,
  });

  factory HiToKoTo.fromJson(Map<String, dynamic> json) {
    return HiToKoTo(
      id: json['id'],
      uuid: json['uuid'],
      hitokoto: json['hitokoto'],
      type: json['type'],
      from: json['from'],
      from_who: json['from_who'] ?? '',
      creator: json['creator'],
      creator_uid: json['creator_uid'],
      reviewer: json['reviewer'],
      commit_from: json['commit_from'],
      created_at: json['created_at'],
      length: json['length'],
    );
  }
}

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  late Future<HiToKoTo> futureHiToKoTo;
  @override
  void initState() {
    super.initState();
    futureHiToKoTo = fetchHiToKoTo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserModel()),
            ],
            child: Consumer<UserModel>(
              builder: (context, value, child) {
                return ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: Text(Global.profile.user?.username ?? '未登录'),
                  onTap: () {
                    Global.profile.user = User()
                      ..mercuriusId = 0
                      ..username = '114'
                      ..email = 'byrdsaron@gmail.com';
                  },
                );
              },
            ),
          ),
          const Divider(
            height: 5,
          ),
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
            onTap: () => _about(context),
          ),
          const Divider(
            height: 5,
          ),
          Container(
            alignment: Alignment.center,
            child: FutureBuilder<HiToKoTo>(
              future: futureHiToKoTo,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.hitokoto,
                    style: TextStyle(
                      fontSize: 12,
                      color: (Theme.of(context).brightness == Brightness.dark)
                          ? Colors.white54
                          : Colors.black54,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Container();
              }),
            ),
          )
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
