import 'package:mercurius/index.dart';

class MercuriusListWidget extends StatelessWidget {
  final EdgeInsets padding;
  final List<Widget> children;
  final bool shrinkWrap;

  const MercuriusListWidget({
    super.key,
    this.padding = const EdgeInsets.only(top: 8),
    this.children = const <Widget>[],
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}
