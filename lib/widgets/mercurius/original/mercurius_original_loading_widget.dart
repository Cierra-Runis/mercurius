import 'package:mercurius/index.dart';

class MercuriusOriginalLoadingWidget extends StatelessWidget {
  const MercuriusOriginalLoadingWidget({
    Key? key,
    this.notice = '读取中',
    this.withText = true,
  }) : super(key: key);

  final String notice;
  final bool withText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.staggeredDotsWave(
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
          if (withText) const SizedBox(width: 20),
          if (withText) Text(notice),
        ],
      ),
    );
  }
}
