import 'package:mercurius/index.dart';

class AppIcon extends StatelessWidget {
  final double size;

  const AppIcon({
    super.key,
    this.size = 48,
  });

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
