import 'package:mercurius/index.dart';

class MercuriusModifiedDoubleBackWidget extends StatefulWidget {
  const MercuriusModifiedDoubleBackWidget({
    Key? key,
    required this.background,
    required this.backgroundRadius,
    required this.child,
    this.condition = true,
    this.duration = const Duration(milliseconds: 600),
    this.margin = const EdgeInsets.fromLTRB(60, 0, 60, 70),
    this.message = '再次返回以退出',
    this.onConditionFail,
    this.onFirstBackPress,
    this.platform = TargetPlatform.android,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.waitForSecondBackPress = 2,
  }) : super(key: key);

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
  State<MercuriusModifiedDoubleBackWidget> createState() =>
      _MercuriusModifiedDoubleBackWidgetState();
}

class _MercuriusModifiedDoubleBackWidgetState
    extends State<MercuriusModifiedDoubleBackWidget> {
  bool tapped = false;

  void resetBackTimeout() {
    tapped = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.platform == TargetPlatform.android) {
      return WillPopScope(
        onWillPop: () async {
          if (widget.condition) {
            if (tapped) {
              return true;
            } else {
              tapped = true;
              Timer(
                Duration(seconds: widget.waitForSecondBackPress),
                resetBackTimeout,
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
          } else {
            if (widget.onConditionFail != null) {
              widget.onConditionFail!();
            }
            return false;
          }
        },
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }
}
