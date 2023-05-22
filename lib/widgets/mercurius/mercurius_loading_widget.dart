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
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primaryContainer,
            size: 16,
          ),
        ],
      ),
    );
  }
}
