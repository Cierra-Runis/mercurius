import 'package:mercurius/index.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
