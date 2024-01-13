import '../../../app/lib/index.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.staggeredDotsWave(
            color: context.brightness.isDark
                ? context.colorScheme.primary
                : context.colorScheme.primaryContainer,
            size: 16,
          ),
        ],
      ),
    );
  }
}
