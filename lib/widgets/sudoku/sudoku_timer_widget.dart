import 'package:mercurius/index.dart';

class SudokuTimerWidget extends StatefulWidget {
  const SudokuTimerWidget({Key? key}) : super(key: key);

  @override
  State<SudokuTimerWidget> createState() => _SudokuTimerWidgetState();
}

class _SudokuTimerWidgetState extends State<SudokuTimerWidget> {
  /// TODO: 完善计时器功能
  late Timer _timer;
  int _passed = 0;

  @override
  void initState() {
    super.initState();

    /// 计时器
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          _passed += 1;
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        '已经过 $_passed 秒',
        key: ValueKey<int>(_passed),
      ),
    );
  }
}
