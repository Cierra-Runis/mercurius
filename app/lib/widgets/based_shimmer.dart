import 'package:mercurius/index.dart';

class BasedShimmer extends StatefulWidget {
  const BasedShimmer({
    super.key,
    this.millisecondsDelay = 0,
    this.radius = 0,
    this.child,
    this.childAlignment = Alignment.center,
    required this.width,
    required this.height,
  });

  final double radius;
  final double width;
  final double height;
  final Widget? child;
  final AlignmentGeometry? childAlignment;

  final int millisecondsDelay;

  const BasedShimmer.round({
    super.key,
    required double size,
    this.millisecondsDelay = 0,
    this.child,
    this.childAlignment,
  })  : height = size,
        width = size,
        radius = size / 2;

  @override
  State<BasedShimmer> createState() => _BasedShimmerState();
}

class _BasedShimmerState extends State<BasedShimmer> {
  static final isHighLightStream = Stream<bool>.periodic(
    Durations.extralong4,
    (x) => x % 2 == 0,
  ).asBroadcastStream();

  bool _isHighLight = true;
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();
    sub = isHighLightStream.listen(
      (isHighLight) {
        if (widget.millisecondsDelay != 0) {
          Future.delayed(
            Duration(milliseconds: widget.millisecondsDelay),
            () => _isHighLight = isHighLight,
          );
        } else {
          _isHighLight = isHighLight;
        }
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 800),
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: _isHighLight
            ? context.colorScheme.outline.withOpacity(0.4)
            : context.colorScheme.outline.withOpacity(0.1),
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      alignment: widget.childAlignment,
      child: widget.child,
    );
  }
}
