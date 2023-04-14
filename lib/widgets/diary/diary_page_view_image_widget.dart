import 'package:mercurius/index.dart';

class DiaryPageViewImageWidget extends StatelessWidget {
  const DiaryPageViewImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    /// TODO: 写界面
    return const Scaffold(
      body: Center(
        child: Text('这里将用于显示图片'),
      ),
    );
  }
}
