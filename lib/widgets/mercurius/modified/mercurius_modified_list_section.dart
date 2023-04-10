import 'package:mercurius/index.dart';

class MercuriusModifiedListSection extends StatelessWidget {
  const MercuriusModifiedListSection({
    Key? key,
    this.title,
    this.summary,
    this.leading,
    this.description,
    this.margin = const EdgeInsets.all(12.0),
    this.children = const <Widget>[],
  }) : super(key: key);

  final Widget? title;
  final Widget? summary;
  final Widget? leading;
  final Widget? description;
  final EdgeInsets? margin;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: title,
              ),
            if (summary != null)
              Container(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: summary,
              ),
            Material(
              type: MaterialType.card,
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  if (leading != null) leading!,
                  Expanded(
                    child: Column(
                      children: [
                        for (var i = 0; i < children.length; i++)
                          Builder(
                            builder: (_) {
                              Widget child = children[i];
                              return Column(
                                children: [
                                  child,
                                  if (i < children.length - 1)
                                    const Divider(
                                      height: 0,
                                      indent: 8,
                                      endIndent: 8,
                                    ),
                                ],
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (description != null)
              Container(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                child: description!,
              ),
          ],
        ),
      ),
    );
  }
}
