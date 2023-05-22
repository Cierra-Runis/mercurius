import 'package:mercurius/index.dart';

class MercuriusSettingPage extends StatelessWidget {
  const MercuriusSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设定'),
      ),
      body: const Center(
        child: MercuriusListWidget(
          children: [
            MercuriusListSectionWidget(
              children: [
                _ThemeSelectListItem(),
                _VibrationSelectListItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSelectListItem extends ConsumerWidget {
  const _ThemeSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        return MercuriusListItemWidget(
          iconData: Icons.dark_mode_rounded,
          titleText: '深色模式',
          detailText: snapshot.data?.themeMode == ThemeMode.system
              ? '跟随系统'
              : snapshot.data?.themeMode == ThemeMode.dark
                  ? '常暗模式'
                  : '常亮模式',
          onTap: () => showDialog<void>(
            context: context,
            builder: (context) {
              return const MercuriusThemeSelectorWidget();
            },
          ),
        );
      },
    );
  }
}

class _VibrationSelectListItem extends ConsumerWidget {
  const _VibrationSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        return MercuriusModifiedListSwitchItem(
          iconData: Icons.vibration,
          titleText: '按钮振动',
          detailText: snapshot.data!.buttonVibration ? '开启' : '关闭',
          value: snapshot.data!.buttonVibration,
          onChanged: (value) => isarService.saveConfig(
            snapshot.data!..buttonVibration = !snapshot.data!.buttonVibration,
          ),
        );
      },
    );
  }
}
