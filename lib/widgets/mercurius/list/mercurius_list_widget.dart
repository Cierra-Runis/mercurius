import 'package:mercurius/index.dart';

class MercuriusListWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final List<Widget> children;
  final bool shrinkWrap;

  const MercuriusListWidget({
    Key? key,
    this.padding,
    this.children = const <Widget>[],
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding ?? const EdgeInsets.only(top: 8),
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }
}
