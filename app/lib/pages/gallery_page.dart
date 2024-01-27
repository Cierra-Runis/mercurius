import 'package:mercurius/index.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Gallery(
      onCardTap: (context, fileName) => context.pushDialog(
        ImageView(fileName: fileName),
      ),
    );
  }
}
