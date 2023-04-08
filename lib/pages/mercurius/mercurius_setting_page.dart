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
        child: MercuriusList(
          children: [
            MercuriusListSection(
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

class _ThemeSelectListItem extends StatelessWidget {
  const _ThemeSelectListItem();

  @override
  Widget build(BuildContext context) {
    return Consumer<MercuriusProfileNotifier>(
      builder: (context, mercuriusProfileNotifier, child) {
        return MercuriusListItem(
          iconData: Icons.dark_mode_rounded,
          titleText: '深色模式',
          detailText: mercuriusProfileNotifier.profile.themeMode! ==
                  ThemeMode.system
              ? '跟随系统'
              : mercuriusProfileNotifier.profile.themeMode! == ThemeMode.dark
                  ? '常暗模式'
                  : '常亮模式',
          onTap: () => _showThemeSelectorWidget(context),
        );
      },
    );
  }

  Future<void> _showThemeSelectorWidget(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const ThemeSelectorWidget();
      },
    );
  }
}

class _VibrationSelectListItem extends StatelessWidget {
  const _VibrationSelectListItem();

  @override
  Widget build(BuildContext context) {
    return Consumer<MercuriusProfileNotifier>(
      builder: (context, mercuriusProfileNotifier, child) {
        return MercuriusListSwitchItem(
          iconData: Icons.vibration,
          titleText: '按钮振动',
          detailText:
              mercuriusProfileNotifier.profile.buttonVibration! ? '开启' : '关闭',
          value: mercuriusProfileNotifier.profile.buttonVibration!,
          onChanged: (value) {
            mercuriusProfileNotifier.changeProfile(
              mercuriusProfileNotifier.profile
                ..buttonVibration =
                    !mercuriusProfileNotifier.profile.buttonVibration!,
            );
          },
        );
      },
    );
  }
}
