import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_upload_images.freezed.dart';
part 'auto_upload_images.g.dart';

@Riverpod(keepAlive: true)
class AutoUploadImages extends _$AutoUploadImages {
  late final StreamSubscription<FileSystemEvent> _subscription;

  @override
  void build() async {
    final paths = ref.watch(pathsProvider);

    _subscription = paths.imageDirectory.watch().listen((event) async {
      App.printLog(event);

      // final gitHub = GitHub(
      //   auth: Authentication.bearerToken(settings.gitHubToken!),
      // );
      // final contents = await gitHub.repositories.getContents(
      //   RepositorySlug(settings.gitHubSlugOwner!, settings.gitHubSlugName!),
      //   'images',
      // );

      // final localImages = paths.imageDirectory.listSync();
      // for (final localImage in localImages) {
      //   for (final uploadedImage in contents.tree ?? []) {
      //     final localImageName = p.basename(localImage.path);

      //     if (uploadedImage.name != localImageName &&
      //         _uploadEvents
      //             .where((upload) => p.basename(upload.path) == localImageName)
      //             .isEmpty) {
      //       _uploadEvents.add(

      //       );
      //     }
      //   }
      // }
    });
  }
}

@riverpod
class GitHubUploadTaskManager extends _$GitHubUploadTaskManager {
  @override
  List<GitHubUploadTask> build() => [];
  List<GitHubUploadTask> addTask(GitHubUploadTask task) =>
      state = [...state, task..startUpload()];
}

@freezed
class GitHubUploadTask with _$GitHubUploadTask {
  const GitHubUploadTask._();
  const factory GitHubUploadTask({
    required String path,
    required File file,
    ProgressCallback? onUploadProgress,
    VoidCallback? onUploadComplete,
  }) = _GitHubUploadTask;

  void startUpload() async {
    final response = await Dio().put(
      path,
      data: {},
      onSendProgress: onUploadProgress,
    );
  }
}
