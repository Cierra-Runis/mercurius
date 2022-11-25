import 'package:mercurius/index.dart';
import 'package:mercurius/states/location_change_notifier.dart';
import 'package:mercurius/states/log_change_notifier.dart';

// 位于 main.dart 的 changeNotifier
ProfileModel profileModel = ProfileModel();
SudokuModel sudokuModel = SudokuModel();
MercuriusWebModel mercuriusWebModel = MercuriusWebModel();
LocationModel locationModel = LocationModel();
LogModel logModel = LogModel();

// 因 profileModel 需要读取本地数据, 故先进入 profileModel 进行初始化
void main() => profileModel.init().then(
      (e) {
        // 进行调试工具的初始化
        DevTools.init();
        // 进入 MercuriusApp()
        runApp(const MercuriusApp());
      },
    );

class MercuriusApp extends StatefulWidget {
  const MercuriusApp({super.key});

  @override
  State<MercuriusApp> createState() => _MercuriusAppState();
}

class _MercuriusAppState extends State<MercuriusApp> {
  @override
  Widget build(BuildContext context) {
    DevTools.printLog('[006] MercuriusApp 构建中');
    // 利用 provide 包进行状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => profileModel),
        ChangeNotifierProvider(create: (_) => sudokuModel),
        ChangeNotifierProvider(create: (_) => mercuriusWebModel),
        ChangeNotifierProvider(create: (_) => locationModel),
        ChangeNotifierProvider(create: (_) => logModel),
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
            // 控制主题样式
            themeMode: profileModel.profile.themeMode,
            // 进入 SplashPage()
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
