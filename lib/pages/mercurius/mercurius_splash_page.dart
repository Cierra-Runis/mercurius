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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          MercuriusKit.printLog('进入主页面');
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
  Widget build(BuildContext context) {
    MercuriusKit.printLog('正在构建 $this');

    ref.watch(githubLatestReleaseProvider);
    ref.watch(isarServiceProvider);
    ref.watch(mercuriusPositionProvider);

    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: null,
                icon: Container(
                  width: 48,
                  height: 48,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/icon/icon.png'),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                        spreadRadius: 4.0,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    MercuriusConstance.name,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Saira',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
