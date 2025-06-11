import 'package:mercurius/index.dart';

class DeprecatedEmbedBuilder extends EmbedBuilder {
  const DeprecatedEmbedBuilder();

  @override
  String get key => 'deprecated';

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    return const Chip(
      label: Text('Deprecated embed'),
    );
  }
}
