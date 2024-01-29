import 'package:mercurius/index.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.imageGallery),
      ),
      body: Gallery(
        onCardTap: (context, filename) => context.pushDialog(
          ImageView(filename: filename),
        ),
      ),
    );
  }
}
