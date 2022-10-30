import 'package:mercurius/index.dart';

ProfileModel profileModel = ProfileModel();

void main() => profileModel.init().then((e) => runApp(const MercuriusApp()));

class MercuriusApp extends StatefulWidget {
  const MercuriusApp({super.key});

  @override
  State<MercuriusApp> createState() => _MercuriusAppState();
}

class _MercuriusAppState extends State<MercuriusApp> {
  @override
  Widget build(BuildContext context) {
    DevTools.printLog('[006] MercuriusApp 构建中');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => profileModel),
      ],
      child: Consumer<ProfileModel>(
        builder: (context, profileModel, child) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              fontFamily: 'HarmonyOS_Sans_SC',
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              fontFamily: 'HarmonyOS_Sans_SC',
            ),
            themeMode: profileModel.profile.themeMode,
            home: const HomeRoute(),
          );
        },
      ),
    );
  }
}
