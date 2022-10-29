import 'package:mercurius/index.dart';

void main() {
  Global.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileModel()),
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
