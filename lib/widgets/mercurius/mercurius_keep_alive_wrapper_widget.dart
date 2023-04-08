import 'package:mercurius/index.dart';

class MercuriusKeepAliveWrapperWidget extends StatefulWidget {
  const MercuriusKeepAliveWrapperWidget({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  State<MercuriusKeepAliveWrapperWidget> createState() =>
      _MercuriusKeepAliveWrapperWidgetState();
}

class _MercuriusKeepAliveWrapperWidgetState
    extends State<MercuriusKeepAliveWrapperWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant MercuriusKeepAliveWrapperWidget oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
