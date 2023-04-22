import 'package:mercurius/index.dart';

class MercuriusGalleryPage extends StatefulWidget {
  const MercuriusGalleryPage({Key? key}) : super(key: key);

  @override
  State<MercuriusGalleryPage> createState() => _MercuriusGalleryPageState();
}

class _MercuriusGalleryPageState extends State<MercuriusGalleryPage> {
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    files = Directory('${mercuriusPathNotifier.path}/image/').listSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片库'),
      ),
      body: ListView(children: [
        for (FileSystemEntity i in files) Image.file(File(i.path))
      ]),
    );
  }
}
