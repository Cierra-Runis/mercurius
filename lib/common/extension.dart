import 'package:mercurius/index.dart';

extension BuildContextExtension on BuildContext {
  L10N get l10n => L10N.of(this);
}
