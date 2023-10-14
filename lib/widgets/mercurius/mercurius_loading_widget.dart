import 'package:mercurius/index.dart';

class MercuriusLoadingWidget extends StatelessWidget {
  const MercuriusLoadingWidget({
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
