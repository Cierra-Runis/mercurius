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
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

    return MercuriusListItemWidget(
      iconData: Icons.dark_mode_rounded,
      titleText: '深色模式',
      detailText: mercuriusProfile.when(
        loading: () => '跟随系统',
        error: (error, stackTrace) => '跟随系统',
        data: (profile) => profile.themeMode! == ThemeMode.system
            ? '跟随系统'
            : profile.themeMode! == ThemeMode.dark
                ? '常暗模式'
                : '常亮模式',
      ),
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) {
          return const MercuriusThemeSelectorWidget();
        },
      ),
    );
  }
}

class _VibrationSelectListItem extends ConsumerWidget {
  const _VibrationSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

    return mercuriusProfile.when(
      loading: () => const MercuriusListItemWidget(),
      error: (error, stackTrace) => Container(),
      data: (profile) {
        return MercuriusModifiedListSwitchItem(
          iconData: Icons.vibration,
          titleText: '按钮振动',
          detailText: profile.buttonVibration! ? '开启' : '关闭',
          value: profile.buttonVibration!,
          onChanged: (value) =>
              ref.watch(mercuriusProfileProvider.notifier).changeProfile(
                    profile..buttonVibration = value,
                  ),
        );
      },
    );
  }
}
