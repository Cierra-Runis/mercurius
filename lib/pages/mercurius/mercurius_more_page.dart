import 'package:mercurius/index.dart';

class MercuriusMorePage extends StatelessWidget {
  const MercuriusMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MercuriusAppBarTitleWidget(),
        centerTitle: true,
        actions: MercuriusWindowsManager.getActions(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MercuriusMorePageListWidget(context: context),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: MercuriusHiToKoToWidget(),
          ),
        ],
      ),
    );
  }
}
