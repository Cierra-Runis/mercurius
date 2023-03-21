import 'package:mercurius/index.dart';

class MercuriusMorePage extends StatelessWidget {
  const MercuriusMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<MercuriusProfileNotifier>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: () {
                Vibration.vibrate(duration: 50, amplitude: 255);
                if (mercuriusProfileNotifier.profile.user == null) {
                  _loginDialog(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MercuriusProfilePage(),
                    ),
                  );
                }
              },
            );
          },
        ),
        title: const MercuriusTitleWidget(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MercuriusList(
              children: [
                MercuriusListSection(
                  children: [
                    MercuriusListItem(
                      icon: Icon(
                        Icons.analytics,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.38),
                      ),
                      title: const Text(
                        '统计数据',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Saira',
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DiaryStatisticPage(),
                        ),
                      ),
                    ),
                    MercuriusListItem(
                      icon: Icon(
                        Icons.settings,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.38),
                      ),
                      title: const Text(
                        '设定',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Saira',
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MercuriusSettingPage(),
                        ),
                      ),
                    ),
                    MercuriusListItem(
                      icon: Icon(
                        Icons.info_outline,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.38),
                      ),
                      title: const Text(
                        '关于',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Saira',
                        ),
                      ),
                      onTap: () => _aboutDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: HiToKoToWidget(),
          )
        ],
      ),
    );
  }

  Future<void> _aboutDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const DialogAboutWidget();
      },
    );
  }

  Future<void> _loginDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginDialogWidget();
      },
    );
  }
}
