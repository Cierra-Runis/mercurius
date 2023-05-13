import 'package:mercurius/index.dart';

class MercuriusMorePage extends StatelessWidget {
  const MercuriusMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MercuriusAppBarUserIconWidget(),
        title: const MercuriusAppBarTitleWidget(),
        centerTitle: true,
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
