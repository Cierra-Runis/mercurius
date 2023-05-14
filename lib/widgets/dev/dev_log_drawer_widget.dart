import 'package:mercurius/index.dart';

class DevLogDrawerWidget extends ConsumerWidget {
  const DevLogDrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.transparent,
        child: MercuriusListWidget(
          children: [
            ListTile(
              title: Text(
                mercuriusProfile.when(
                  data: (data) => jsonEncode(data.toJson()),
                  error: (error, stackTrace) => '$error\n$stackTrace',
                  loading: () => 'loading...',
                ),
                style: const TextStyle(fontSize: 8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
