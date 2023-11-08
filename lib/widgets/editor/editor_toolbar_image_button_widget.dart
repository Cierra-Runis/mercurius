import 'package:mercurius/index.dart';

class EditorToolbarImageButtonWidget extends CustomButton {
  EditorToolbarImageButtonWidget({
    super.key,
    super.icon = Icons.add_photo_alternate_rounded,
    super.iconTheme,
    required super.tooltip,
    required this.controller,
    required this.context,
    required String path,
  }) : super(onPressed: () => _onPressed(controller, context, path));

  final BuildContext context;
  final QuillController controller;

  static void _onPressed(
    QuillController controller,
    BuildContext context,
    String path,
  ) async {
    final l10n = context.l10n;

    bool? newImage = await ConfirmDialog(
      context: context,
      title: l10n.insertTheImageFrom,
      summary: '${l10n.imageGallery}？${l10n.systemFile}？',
      trueString: l10n.systemFile,
      falseString: l10n.imageGallery,
    ).confirm;

    switch (newImage) {
      case true:

        /// TIPS: 安卓启用新版本
        final ImagePickerPlatform imagePickerImplementation =
            ImagePickerPlatform.instance;
        if (imagePickerImplementation is ImagePickerAndroid) {
          imagePickerImplementation.useAndroidPhotoPicker = true;
        }

        /// TIPS: 这里返还的是图片地址
        /// TIPS: 缓存于 `/data/user/0/pers.cierra_runis.mercurius/cache/` 下
        /// TIPS: 而不是可见于 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/cache/` 下
        /// TIPS: 这会导致用户清除缓存后图片无法加载的问题
        /// TIPS: 故修改图片地址至 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/image/` 下
        /// TIPS: 并删除所需的中间缓存图片

        XFile? pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        if (pickedFile != null) {
          String sourceFilePath = pickedFile.path;
          String targetFilePath = '$path/image/${pickedFile.name}';

          await XFile(sourceFilePath).saveTo(targetFilePath);
          if (Platform.isAndroid) {
            await File(sourceFilePath).delete();
          }
          _insert(controller, pickedFile.name);
        }
        break;
      case false:
        if (context.mounted) {
          String? filename = await context.push(
            const GalleryPage(readOnly: true),
          );
          if (filename != null) {
            _insert(controller, filename);
          }
        }
        break;
      default:
        return;
    }
  }

  static void _insert(QuillController controller, String filename) {
    controller.document.insert(controller.selection.extentOffset, '\n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(
      controller.selection.extentOffset,
      ImageBlockEmbed(filename),
    );

    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, ' ');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, '\n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );
  }
}
