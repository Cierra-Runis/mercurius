import 'package:mercurius/index.dart';

class MercuriusAppNameWidget extends StatelessWidget {
  const MercuriusAppNameWidget({
    super.key,
    this.fontSize,
  });

  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      Mercurius.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        fontFamily: 'Saira',
      ),
    );
  }
}
