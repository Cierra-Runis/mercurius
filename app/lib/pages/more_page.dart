import '../../app/lib/index.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MorePageList(context: context),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: HiToKoToWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
