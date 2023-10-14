import 'package:mercurius/index.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    this.fontSize,
  });

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      Mercurius.name,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
    );
  }
}
