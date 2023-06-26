import 'package:mercurius/index.dart';

class MercuriusSplashPage extends ConsumerStatefulWidget {
  const MercuriusSplashPage({super.key});

  @override
  ConsumerState<MercuriusSplashPage> createState() =>
      _MercuriusSplashPageState();
}

class _MercuriusSplashPageState extends ConsumerState<MercuriusSplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    Mercurius.printLog('正在初始化 $this');

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Mercurius.printLog('进入主页面');
          Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => const MercuriusRoute(),
            ),
            (route) => false,
          );
        }
      },
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Mercurius.printLog('正在构建 $this');

    return FadeTransition(
      opacity: _animation,
      child: const Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MercuriusAppIconWidget(),
              MercuriusAppNameWidget(
                fontSize: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
