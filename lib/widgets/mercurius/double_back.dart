import 'package:mercurius/index.dart';

class DoubleBack extends StatefulWidget {
  const DoubleBack({
    super.key,
    required this.background,
    required this.backgroundRadius,
    required this.message,
    required this.child,
    this.condition = true,
    this.duration = const Duration(milliseconds: 600),
    this.margin = const EdgeInsets.fromLTRB(60, 0, 60, 70),
    this.onConditionFail,
    this.onFirstBackPress,
    this.platform = TargetPlatform.android,
    this.textStyle = const TextStyle(fontWeight: FontWeight.w600),
    this.waitForSecondBackPress = 2,
  });

  final Color background;
  final BorderRadius backgroundRadius;
  final Widget child;
  final bool condition;
  final Duration duration;
  final EdgeInsets margin;
  final String message;
  final VoidCallback? onConditionFail;
  final Function? onFirstBackPress;
  final TargetPlatform platform;
  final TextStyle textStyle;
  final int waitForSecondBackPress;

  @override
  State<DoubleBack> createState() => _DoubleBackState();
}

class _DoubleBackState extends State<DoubleBack> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (splitViewKey.currentState?.canPop() == true) {
          splitViewKey.currentState?.pop();
          return false;
        }

        if (widget.condition) {
          if (_tapped) return true;

          _tapped = true;
          Timer(
            Duration(seconds: widget.waitForSecondBackPress),
            () => _tapped = false,
          );
          if (widget.onFirstBackPress != null) {
            widget.onFirstBackPress!(context);
          } else {
            Flushbar(
              icon: const Icon(UniconsLine.exit),
              isDismissible: false,
              messageText: Center(
                child: Text(widget.message, style: widget.textStyle),
              ),
              margin: widget.margin,
              barBlur: 1.0,
              borderRadius: widget.backgroundRadius,
              backgroundColor: widget.background,
              boxShadows: const [
                BoxShadow(
                  color: Colors.transparent,
                  offset: Offset(0, 16),
                ),
              ],
              duration: widget.duration,
            ).show(context);
          }
          return false;
        }
        if (widget.onConditionFail != null) {
          widget.onConditionFail!();
        }
        return false;
      },
      child: widget.child,
    );
  }
}
