import 'package:mercurius/index.dart';

class MercuriusOriginalAppIconWidget extends StatelessWidget {
  const MercuriusOriginalAppIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          'assets/icon/icon.png',
          height: 48,
        ),
      ),
    );
  }
}
