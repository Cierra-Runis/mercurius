import 'package:mercurius/index.dart';

import 'package:flutter/cupertino.dart';

/// 位于 `main.dart` 的 `changeNotifier` 们
ProfileModel profileModel = ProfileModel();
SudokuModel sudokuModel = SudokuModel();
MercuriusWebModel mercuriusWebModel = MercuriusWebModel();
PositionModel positionModel = PositionModel();
LogModel logModel = LogModel();
PathModel pathModel = PathModel();
DiaryEditorModel diaryEditorModel = DiaryEditorModel();
DiarySearchTextModel diarySearchTextModel = DiarySearchTextModel();

/// 数据库服务
final isarService = IsarService();

/// 因 `profileModel` 需要读取本地数据, 故先进入 `profileModel` 进行初始化
void main() => profileModel.init().then((e) => runApp(const MercuriusApp()));

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MercuriusApp extends StatelessWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context) {
    DevTools.printLog('MercuriusApp 构建中');

    /// 利用 `provide` 包进行状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => profileModel),
        ChangeNotifierProvider(create: (_) => sudokuModel),
        ChangeNotifierProvider(create: (_) => mercuriusWebModel),
        ChangeNotifierProvider(create: (_) => positionModel),
        ChangeNotifierProvider(create: (_) => pathModel),
        ChangeNotifierProvider(create: (_) => logModel),
        ChangeNotifierProvider(create: (_) => diaryEditorModel),
        ChangeNotifierProvider(create: (_) => diarySearchTextModel),
      ],
      child: Consumer<ProfileModel>(
        builder: (context, profileModel, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              fontFamily: 'Saira',
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              fontFamily: 'Saira',
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
