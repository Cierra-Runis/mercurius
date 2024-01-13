import '../../../app/lib/index.dart';

class DeprecatedEmbedBuilder extends EmbedBuilder {
  const DeprecatedEmbedBuilder();

  @override
  String get key => 'deprecated';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return const Chip(
      label: Text('Deprecated embed'),
    );
  }
}
