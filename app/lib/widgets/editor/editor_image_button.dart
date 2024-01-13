import '../../../app/lib/index.dart';

class EditorImageButton extends QuillToolbarCustomButtonOptions {
  const EditorImageButton({
    required super.tooltip,
    super.iconTheme,
    super.icon = const Icon(
      Icons.add_photo_alternate_rounded,
    ),
    required super.onPressed,
  });

  static void onTap(
    QuillController controller,
    BuildContext context,
  ) async {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    final newImage = await ConfirmDialog(
      context: context,
      title: l10n.insertTheImageFrom,
      summary: '${l10n.imageGallery}？${l10n.systemFile}？',
      trueString: l10n.systemFile,
      falseString: l10n.imageGallery,
    ).confirm;

    if (newImage == null) return;

    if (newImage) {
      /// TIPS: 安卓启用新版本
      final imagePickerImplementation = ImagePickerPlatform.instance;
      if (imagePickerImplementation is ImagePickerAndroid) {
        imagePickerImplementation.useAndroidPhotoPicker = true;
      }

      /// TIPS: 这里返还的是图片地址
      /// TIPS: 缓存于 `/data/user/0/pers.cierra_runis.mercurius/cache/` 下
      /// TIPS: 而不是可见于 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/cache/` 下
      /// TIPS: 这会导致用户清除缓存后图片无法加载的问题
      /// TIPS: 故修改图片地址至 `/storage/emulated/0/Android/data/pers.cierra_runis.mercurius/image/` 下
      /// TIPS: 并删除所需的中间缓存图片

      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        final image = DiaryImage(
          id: 0,
          title: pickedFile.name,
          createDateTime: DateTime.now(),
          data: await pickedFile.readAsBytes(),
        );
        isarService.saveDiaryImage(image);
        _insert(controller, image);
      }
    } else {
      if (context.mounted) {
        final image = await context.push<DiaryImage?>(
          GalleryPage(
            onTap: (context, image) => context.pop(image),
          ),
        );
        if (image != null) {
          _insert(controller, image);
        }
      }
    }
  }

  static void _insert(QuillController controller, DiaryImage image) {
    controller.document.insert(controller.selection.extentOffset, '\n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(
      controller.selection.extentOffset,
      ImageBlockEmbed(image.id),
    );

    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, ' \n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 2,
      ),
      ChangeSource.local,
    );
  }
}
