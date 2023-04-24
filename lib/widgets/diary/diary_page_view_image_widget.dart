import 'package:mercurius/index.dart';

class DiaryPageViewImageWidget extends StatelessWidget {
  const DiaryPageViewImageWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageUrl.split('/').last),
      ),
      body: Center(
        child: PhotoView(
          enableRotation: true,
          backgroundDecoration: const BoxDecoration(),
          imageProvider: FileImage(File(imageUrl)),
        ),
      ),
    );
  }
}
