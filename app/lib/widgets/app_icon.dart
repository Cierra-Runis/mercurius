import 'package:mercurius/index.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    this.size = 48,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 3),
      child: SvgPicture.asset(
        'assets/icon/icon.svg',
        height: size,
        width: size,
      ),
    );
  }
}
