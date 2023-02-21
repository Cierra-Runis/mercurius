import 'package:mercurius/index.dart';

class MercuriusList extends StatelessWidget {
  final EdgeInsets? padding;
  final List<Widget> children;

  const MercuriusList({
    Key? key,
    this.padding,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding ?? const EdgeInsets.only(top: 8),
      children: children,
    );
  }
}
