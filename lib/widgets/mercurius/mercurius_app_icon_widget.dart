import 'package:mercurius/index.dart';

class MercuriusAppIconWidget extends StatelessWidget {
  const MercuriusAppIconWidget({
    super.key,
    this.size = 48,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 3),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 3),
        child: Image.asset(
          'assets/icon/icon.png',
          height: size,
        ),
      ),
    );
  }
}
