import 'package:mercurius/index.dart';

class DoubleBack extends ConsumerStatefulWidget {
  const DoubleBack({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<DoubleBack> createState() => _DoubleBackState();
}

class _DoubleBackState extends ConsumerState<DoubleBack> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    final message = l10n.backAgainToExit;
    final background = context.colorScheme.outline.withAlpha(16);
    final backgroundRadius = BorderRadius.circular(16);

    final currentIndex = ref.watch(currentIndexProvider);
    final setCurrentIndex = ref.watch(currentIndexProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        if (splitViewKey.currentState?.canPop() == true) {
          splitViewKey.currentState?.pop();
          return false;
        }

        if (currentIndex != 0) {
          setCurrentIndex.changeTo(0);
          return false;
        }

        if (_tapped) return true;

        _tapped = true;

        Timer(
          const Duration(seconds: 2),
          () => _tapped = false,
        );

        Flushbar(
          icon: const Icon(UniconsLine.exit),
          isDismissible: false,
          messageText: Center(
            child: Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          margin: const EdgeInsets.fromLTRB(60, 0, 60, 70),
          barBlur: 1.0,
          borderRadius: backgroundRadius,
          backgroundColor: background,
          boxShadows: const [
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(0, 16),
            ),
          ],
          duration: const Duration(milliseconds: 600),
        ).show(context);

        return false;
      },
      child: widget.child,
    );
  }
}
