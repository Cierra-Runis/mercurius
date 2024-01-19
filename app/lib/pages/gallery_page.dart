// import 'package:mercurius/index.dart';

// class GalleryPage extends ConsumerWidget {
//   const GalleryPage({
//     super.key,
//     this.readOnly = false,
//     required this.onTap,
//   });

//   final bool readOnly;
//   final void Function(BuildContext context, DiaryImage image) onTap;

//   Widget getGridBySnapshotData(
//     BuildContext context,
//     AsyncSnapshot<List<DiaryImage>> snapshot,
//   ) {
//     final l10n = L10N.maybeOf(context) ?? L10N.current;

//     if (snapshot.data == null || snapshot.data!.isEmpty) {
//       return Center(child: Text(l10n.noData));
//     }

//     final images = snapshot.data!;

//     return GridView.builder(
//       cacheExtent: 1000,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       padding: const EdgeInsets.all(12.0),
//       itemCount: images.length,
//       itemBuilder: (context, index) => GalleryCard(
//         readOnly: readOnly,
//         onTap: onTap,
//         diaryImage: images[index],
//       ),
//     );
//   }

//   Widget getBodyBySnapshotState(
//     BuildContext context,
//     AsyncSnapshot<List<DiaryImage>> snapshot,
//   ) {
//     if (snapshot.hasError) {
//       return Center(child: Text('Steam error: ${snapshot.error}'));
//     }
//     switch (snapshot.connectionState) {
//       case ConnectionState.none:
//         return const Center(child: Icon(UniconsLine.data_sharing));
//       case ConnectionState.waiting:
//         return const Loading();
//       case ConnectionState.active:
//         return getGridBySnapshotData(context, snapshot);
//       case ConnectionState.done:
//         return const Center(child: Text('Stream closed'));
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final settingsNotifier = ref.watch(settingsProvider.notifier);

//     final l10n = L10N.maybeOf(context) ?? L10N.current;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(l10n.imageGallery),
//         actions: [
//           if (readOnly)
//             TextButton(
//               onPressed: () {
//                 settingsNotifier.setBgImgId(null);
//                 context.pop();
//               },
//               child: Text(l10n.clear),
//             ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: isarService.listenToAllDiaryImages(),
//         builder: getBodyBySnapshotState,
//       ),
//     );
//   }
// }
