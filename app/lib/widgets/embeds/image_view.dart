import 'package:mercurius/index.dart';

// class ImageView extends ConsumerWidget {
//   const ImageView({
//     super.key,
//     required this.image,
//   });

//   final DiaryImage image;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Stack(
//       children: [
//         Center(
//           child: PhotoView(
//             enableRotation: true,
//             backgroundDecoration: const BoxDecoration(),
//             tightMode: true,
//             imageProvider: image.provider,
//           ),
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: CloseButton(
//             onPressed: context.pop,
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 24.0),
//             child: Text(image.title),
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: IconButton(
//             onPressed: () => Share.shareXFiles([
//               XFile.fromData(image.uint8list),
//             ]),
//             icon: const Icon(UniconsLine.share),
//           ),
//         ),
//       ],
//     );
//   }
// }
