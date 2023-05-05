import 'package:mercurius/index.dart';

class DiaryImageViewWidget extends StatelessWidget {
  const DiaryImageViewWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: PhotoView(
            enableRotation: true,
            backgroundDecoration: const BoxDecoration(),
            tightMode: true,
            imageProvider: FileImage(File(imageUrl)),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CloseButton(
            onPressed: () {
              MercuriusKit.vibration();
              Navigator.of(context).pop();
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(imageUrl.split('/').last),
          ),
        )
      ],
    );
  }
}
