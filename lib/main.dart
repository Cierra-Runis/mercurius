import 'package:mercurius/index.dart';

import 'package:flutter/cupertino.dart';

/// 位于 `main.dart` 的 `changeNotifier` 们
ProfileModel profileModel = ProfileModel();
SudokuModel sudokuModel = SudokuModel();
MercuriusWebModel mercuriusWebModel = MercuriusWebModel();
LocationModel locationModel = LocationModel();
LogModel logModel = LogModel();
PathModel pathModel = PathModel();
DiaryEditorModel diaryEditorModel = DiaryEditorModel();

/// 因 `profileModel` 需要读取本地数据, 故先进入 `profileModel` 进行初始化
void main() => profileModel.init().then((e) => runApp(const MercuriusApp()));

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MercuriusApp extends StatefulWidget {
  const MercuriusApp({super.key});

  @override
  State<MercuriusApp> createState() => _MercuriusAppState();
}

class _MercuriusAppState extends State<MercuriusApp> {
  @override
  Widget build(BuildContext context) {
    DevTools.printLog('[006] MercuriusApp 构建中');

    /// 利用 `provide` 包进行状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => profileModel),
        ChangeNotifierProvider(create: (_) => sudokuModel),
        ChangeNotifierProvider(create: (_) => mercuriusWebModel),
        ChangeNotifierProvider(create: (_) => locationModel),
        ChangeNotifierProvider(create: (_) => pathModel),
        ChangeNotifierProvider(create: (_) => logModel),
        ChangeNotifierProvider(create: (_) => diaryEditorModel)
      ],
      child: Consumer<ProfileModel>(
        builder: (context, profileModel, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
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
            home: const SplashPage(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
            ],
          );
        },
      ),
    );
  }
}
